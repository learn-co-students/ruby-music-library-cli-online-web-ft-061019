class Artist
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs, :genre

   @@all = []

   def initialize(name)
    @name = name
    @songs = []
  end

   def self.all
    @@all
  end

   def self.destroy_all
    self.all.clear
  end

   def save
    self.class.all << self
  end

   def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end

   def songs
    @songs
  end

   def add_song(song)
    song.artist = self unless song.artist
    songs << song unless songs.include?(song)
  end

   def song_map
    Song.all.select do |song|
      song.artist == self
    end
  end

   def genres
    songs.map{ |s| s.genre }.uniq
  end

 end
