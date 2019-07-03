require_relative "../lib/concerns/findable.rb"

class Genre
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

    def artists
        songs.map(&:artist).uniq
    end

    def self.create (name)
        self.new(name).tap do |genre|
            genre.save
        end
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end
end