require_relative "../lib/concerns/findable.rb"

class Artist
    attr_accessor :name, :songs

    extend Concerns::Findable
    

    @@all = []

    def initialize (name)
        @name = name
        @songs = []
    end

    def save
        @@all << self
    end

    def add_song (song)
        song.artist = self unless song.artist
        songs << song unless songs.include?(song)
    end

    def genres
        songs.map(&:genre).uniq
    end

    def self.create (name)
        self.new(name).tap do |artist|
            artist.save
        end
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end
end