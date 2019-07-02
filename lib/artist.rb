require_relative "../config/environment"

# This file will define the Artist class and its various methods and attributes
class Artist
   attr_accessor :name, :songs

   @@all = []
   #This adds the class methods I made in the module below to the Artist Class
   #This should add #find_by_name and #find_or_create_by_name methods to this class
   extend Concerns::Findable


   def initialize(name)
      self.name = name
      self.songs = []
   end

   def save
      self.class.all << self
   end
   
   def add_song(song_obj)
         #This next bit of code kind of smells a bit / not super easy to understand
         #This next line says, add the song_obj into the artist's songs array unless I find that the song already exists in the artist's song array
         self.songs << song_obj unless self.songs.detect {|artists_songs| artists_songs.name == song_obj.name}
         #This adds artist reciprocity but only if there is not an artist already specified.
         song_obj.artist = self if song_obj.artist == nil 
   end
   

   def self.create(name)
      self.new(name).tap {|new_Artist_obj| new_Artist_obj.save}
   end

   #Class Methods
   def self.all
      @@all
   end

   def self.destroy_all
      self.all.clear
   end

end