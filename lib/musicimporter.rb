class MusicImporter 
attr_accessor :path 

def initialize(path)
  @path = path
end
  
def files
    Dir[@path+"/*.mp3"].map do |file|
      file.split("/").last
    end
  end
  
 def import
    files.each{ |x| Song.create_from_filename(x)}
  end


  
end