require_relative "../lib/concerns/findable.rb"

class Song
    attr_accessor :name, :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil) 
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def save
        @@all << self
    end

    def artist= (artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre= (genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.find_by_name(name)
        self.all.find { |artist| artist.name == name }
    end

    def self.find_or_create_by_name (name)
        if artist = self.find_by_name(name)
            artist
        else
            self.create(name)
        end
    end


    def self.create(name)
        self.new(name).tap do |song|
            song.save
        end
    end

    def self.new_from_filename(file)
        name_parts = file.split(" - ")
        binding.pry
        artist = Artist.find_or_create_by_name(artist_name)
        song = Song.new(song_name, artist_name, genre_name)
        song.artist = artist
        artist.add_song(song)
        song
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end
end