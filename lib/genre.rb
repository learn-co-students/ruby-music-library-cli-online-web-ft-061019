require_relative "../config/environment"

# This file will define the Genre class and its various methods and attributes
class Genre
   attr_accessor :name, :songs

   @@all = []
   #This adds the class methods I made in the module below to the Genre Class
   #This should add #find_by_name and #find_or_create_by_name methods to this class
   extend Concerns::Findable


   def initialize(name)
      self.name = name
      self.songs = []
   end

   def save
      self.class.all << self
   end
   
   def self.create(name)
      self.new(name).tap {|new_genre_obj| new_genre_obj.save}
   end

   #Class Methods
   def self.all
      @@all
   end

   def self.destroy_all
      self.all.clear
   end

end