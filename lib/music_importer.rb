class MusicImporter 

    attr_accessor :path, :files 

    def initialize(path)
        @path = path 
    end 

    def path
        @path  
    end 

    def files 
        files = Dir.glob("#{path}/*.mp3")
        files.map do |filename|
            filename.gsub("#{path}/", "")
        end 
        ##Referenced from StackOverflow : How to return imported formatted filenames from path ?
    end 

    def import 
        files.each {|filename| Song.create_from_filename(filename)}
    end 
end 