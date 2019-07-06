class Song
  attr_accessor :name
  attr_reader :artist, :genre

   @@all = []

   def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist !=nil
      self.artist = artist
    end
    if genre !=nil
      self.genre = genre
    end
  end

   def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

   def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
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
    song = Song.new(name)
    song.save
    song
  end

   def self.find_by_name(name)
    self.all.find{|song| song.name == name}
  end

   def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

   def self.new_from_filename(filename)
    name = filename.split(" - ")[1]
    artist = Artist.find_or_create_by_name(filename.split(" - ")[0])
    genre = Genre.find_or_create_by_name(filename.split(" - ")[2].chomp(".mp3"))
    self.new(name, artist, genre)
  end

   def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end

 end
