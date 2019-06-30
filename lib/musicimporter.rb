require 'pry'



class MusicImporter
    attr_accessor :path, :files

    def initialize(path)
        self.path = path
    end

    def files
        mp3_path = Dir.open(self.path)
        mp3_file = mp3_path.map{|file| file}
        2.times{mp3_file.shift}
        mp3_file
                
    end

    def import 
        files.each{|file| Song.create_from_filename(file)}
    end

end