require_relative "../config/environment"

# This file will define the Song class and its various methods and attributes
class Song
   attr_accessor :name
   attr_reader :artist, :genre

   @@all = []
   #This adds the class methods I made in the module below to the Song Class
   #This should add #find_by_name and #find_or_create_by_name methods to this class
   extend Concerns::Findable


   def initialize(name, artist_obj = nil, genre = nil)
      self.name = name
      #This somewhat limits what can be stored in the Song.artist attribute -- only an Artist obj or nil.
      if artist_obj
         self.artist = artist_obj
      end

      if genre
         self.genre = genre
      end
   end

   def save
      self.class.all << self
   end

   def artist=(artist_obj)
      @artist = artist_obj
      #Add the song to the Artist's songs array unless a copy of the song is already in there. 
      artist_obj.add_song(self) unless artist_obj.songs.detect {|artist_song| artist_song.name == self.name}
   end
   
   def genre=(genre_obj)
      if genre_obj.class == Genre
         @genre = genre_obj
         genre_obj.songs << self unless genre_obj.songs.detect {|genre_song| genre_song.name == self.name}
      end
         #@genre
   end
   

   def self.create(name)
      self.new(name).tap {|new_song_obj| new_song_obj.save}
   end

   #Class Methods
   def self.all
      @@all
   end

   def self.destroy_all
      self.all.clear
   end

end