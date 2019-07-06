class MusicImporter
  attr_reader :path

   def initialize(path)
    @path = path
  end

   def files
   files = Dir["#{@path}/*.mp3"]
   directory = []

    files.each do |file|
     directory << file.split("#{@path}/")[1]
   end
   directory
    end

   def import
   files.each {|file| Song.create_from_filename(file)}
 end
end
