require 'pry'

class Song
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

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.find_by_name(name)
        all.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end

    def self.new_from_filename(song)
        song_split = song.split(" - ")
        song_name = song_split[1]
        artist = Artist.find_or_create_by_name(song_split[0])
        genre = Genre.find_or_create_by_name(song_split[2].split(".")[0])
        new(song_name, artist, genre)        
    end

    def self.create_from_filename(song)
        new_from_filename(song).tap{|x| x.save}

    end

    
end