class MusicLibraryController
   def initialize(path)
      MusicImporter.path = path
   end
end