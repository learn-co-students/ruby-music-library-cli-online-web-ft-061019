class MusicLibraryController
    attr_accessor :path
    def initialize(path = './db/mp3s')
        @path = path
        MusicImporter.new(path).import
    end

    def call
        puts "Welcome to your music library!"
        while true
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"

            user_input = gets.chomp

            user_input == 'exit' ? break : commands(user_input)
            # break if user_input == 'exit'
        end
    end

    def list_songs(play = nil)
        # Get unique list of all the songs
        all_song_uniq = Song.all.uniq
        # Sort by song name
        all_song_uniq.sort! {|a, b| a.name <=> b.name}
        # Generate a collection of songs string
        # all_song_uniq.collect!.with_index(1) {|song, i| "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
        all_song_uniq.collect! {|song| "#{song.artist.name} - #{song.name} - #{song.genre.name}"}

        ## Return the songs with play is true
        return all_song_uniq if play

        # puts songs a number list
        all_song_uniq.each.with_index(1) {|song, i| puts "#{i}. #{song}"}
    end

    def list_artists
        # Get all artists
        all_artist_uniq = Artist.all.uniq
        # Sort by artist name
        all_artist_uniq.sort! {|a, b| a.name <=> b.name}
        # Generate collect string
        # all_artist_uniq.collect!.with_index(1) {|artist, i| "#{i}. #{artist.name}"}
        all_artist_uniq.collect!{|artist| "#{artist.name}"}
        # Puts artists a number list
        all_artist_uniq.each.with_index(1) {|artist, i| puts "#{i}. #{artist}"}

    end

    def list_genres
        # Get all genre
        all_genre_uniq = Genre.all.uniq
        # Sort by genre name
        all_genre_uniq.sort! {|a, b| a.name <=> b.name}
        # Generate collect string
        all_genre_uniq.collect! {|genre| "#{genre.name}"}
        # Puts genre a number list
        all_genre_uniq.each.with_index(1) {|genre, i| puts "#{i}. #{genre}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        user_input = gets.chomp
        unless Artist.find_by_name(user_input).nil?

            # Get artist with songs
            songs = Artist.find_by_name(user_input).songs
            # Order artist songs by song name
            songs.sort! {|a, b| a.name <=> b.name}
            # Make collection
            songs.collect! {|song| "#{song.name} - #{song.genre.name}"}
            # Puts collection
            songs.each.with_index(1) {|song, i| puts "#{i}. #{song}"}
        end

    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        user_input = gets.chomp
        unless Genre.find_by_name(user_input).nil?
            # Get all genres songs
            genre_songs = Genre.find_by_name(user_input).songs
            # Sort genres songs by name
            genre_songs.sort! {|a, b| a.name <=> b.name}
            # Make collection of genre string
            genre_songs.collect! {|song| "#{song.artist.name} - #{song.name}"}
            # Puts each item in collection
            genre_songs.each.with_index(1) {|genre, i| puts "#{i}. #{genre}"}
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        user_input = gets.chomp

        # If user inputs number
        if user_input.to_i >= 1
            songs = list_songs(play = true)
            # Check if user request is in list
            unless songs[user_input.to_i - 1].nil?
                artist, song, genre = songs[user_input.to_i - 1].split(" - ")
                puts "Playing #{song} by #{artist}"
            end
        end
    end

    def methods(command)
        {
            "list_songs" => list_songs(),
            "list_artists" => list_artists(),
            "list_genres" => list_genres(),
            "list_artist" => list_songs_by_artist(),
            "list_genre" => list_songs_by_genre(),
            "play_song" => play_song(),
        }
    end

    def commands(command)
        options = ['list songs', 'list artists', 'list genres', 'list artist', 'list genre', 'play song']
        options.find {|option| option == command}.nil? ? "That command is not available, try again." : methods(command.split.join("_"))
    end

end
