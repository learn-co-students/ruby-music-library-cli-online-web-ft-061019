class Song
    extend Concerns::Findable 
    attr_accessor :name, :artist, :genre
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        self.name = name
        self.artist = artist if artist != nil
        self.genre = genre if genre != nil
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name, artist = nil, genre = nil)
        song = self.new(name)
        song.save
        song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre 
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.find_by_name(name)
        all.detect.each do |song|
            song.name == name 
        end 
    end 

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end 
        
    def self.new_from_filename(file)
        song_info = file.split(" - ")
        artist_name, song_name, genre_name = song_info[0], song_info[1], song_info[2].gsub(".mp3", "")
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)
        self.new(song_name, artist, genre)
        #Referenced from StackOverflow : How to remove .mp3 from filename?
    end 
   
    def self.create_from_filename(filename)
        new_from_filename(filename).tap {|song| song.save}
    end 
end 