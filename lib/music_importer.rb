class MusicImporter
   attr_accessor :path

   @@all = []

   def initialize(path)
      self.path = path
   end

   def save
      self.class.all << self
   end

   def files
      Dir[self.path + "/*.mp3"].map {|filename| filename.gsub("#{self.path}/", "")}
   end
   
   
   def import
      self.files.each {|file| Song.create_from_filename(file)}
   end 
   

   def self.all
      @@all
   end
end