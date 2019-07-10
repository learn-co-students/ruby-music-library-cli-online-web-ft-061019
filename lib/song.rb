require 'pry'
class Song
    extend Concerns::Findable
    attr_accessor :name, :artist, :genre
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        @@all << self
        self.artist = artist unless artist.nil?
        self.genre = genre unless genre.nil?
    end

    def self.all
        @@all
    end

    def self.destroy_all
        self.all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        if self.all.detect {|song| song.name == name}.nil?
            song = Song.new(name)
            song
        end
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.add_song(self)
    end

    # def self.find_by_name(song_name)
    #     self.all.detect { |i| i.name == song_name }
    # end

    # def self.find_or_create_by_name(song_name)
    #     self.find_by_name(song_name).nil? ? (self.create(song_name)) : (self.find_by_name(song_name))
    # end

    def self.new_from_filename(file_name)
        # binding.pry
        artist_name, song_name, song_genre = file_name.split(" - ")
        song_genre = song_genre.gsub(".mp3", "")

        song = find_or_create_by_name(song_name)
        song.artist = Artist.find_or_create_by_name(artist_name)
        song.genre = Genre.find_or_create_by_name(song_genre)

        # binding.pry
        song
    end

    def self.create_from_filename(file_name)
        song = new_from_filename(file_name)
        song.save
    end

end