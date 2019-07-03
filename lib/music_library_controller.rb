class MusicLibraryController
   attr_accessor :path, :input

   def initialize(path = './db/mp3s')
      MusicImporter.new(path).import
   end

   def call
      puts "Welcome to your music library!"
      until self.input == 'exit' do 
         puts "To list all of your songs, enter \'list songs\'."
         puts "To list all of the artists in your library, enter \'list artists\'."
         puts "To list all of the genres in your library, enter \'list genres\'."
         puts "To list all of the songs by a particular artist, enter \'list artist\'."
         puts "To list all of the songs of a particular genre, enter \'list genre\'."
         puts "To play a song, enter \'play song\'."
         puts "To quit, type \'exit\'."
         puts "What would you like to do?"
         self.input = gets.chomp

         case self.input

         when 'list songs'
            list_songs
         when 'list artists'
            list_artists
         when 'list genres'
            list_genres
         when 'list artist'
            list_songs_by_artist
         when 'list genre'
            list_songs_by_genre
         when 'play song'
            play_song
         end
         
      end
   end
   
   def list_songs
      Song.all.sort_by {|song| song.name}.map.with_index {|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
   end

   def list_songs_array
      Song.all.sort_by {|song| song.name}.map {|song| {:artist_name => song.artist.name, :song_name => song.name}}
   end

   def list_artists
      Artist.all.sort_by {|artist| artist.name}.each.with_index {|artist, index| puts "#{index + 1}. #{artist.name}"}
   end

   def list_genres
      Genre.all.sort_by {|genre| genre.name}.each.with_index {|genre, index| puts "#{index + 1}. #{genre.name}"}
   end

   def list_songs_by_artist
      puts "Please enter the name of an artist:"
      artist_name = gets.chomp
      artist_obj = Artist.find_by_name(artist_name)
      artist_obj.songs.sort_by {|song| song.name}.each.with_index {|song, index| puts "#{index + 1}. #{song.name} - #{song.genre.name}"} unless artist_obj == nil
   end

   def list_songs_by_genre
      puts "Please enter the name of a genre:"
      genre_name = gets.chomp
      genre_obj = Genre.find_by_name(genre_name)
      genre_obj.songs.sort_by {|song| song.name}.each.with_index {|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name}"} unless genre_obj == nil
   end

   def play_song
      puts "Which song number would you like to play?"
      total_amount_of_songs = list_songs_array.length
 
      selected_song_input = gets.chomp
      selected_song_int = selected_song_input.to_i

      if selected_song_int < total_amount_of_songs && selected_song_int >= 1
         song_to_play = list_songs_array[selected_song_int - 1]
         puts "Playing #{song_to_play[:song_name]} by #{song_to_play[:artist_name]}"
      end
   end
end