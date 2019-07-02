require 'bundler'
Bundler.require

module Concerns
   module Findable
      #these are all going to be CLASS methods so self has been left off the method names

      def find_by_name(name)
         self.detect {|element| element.name == name}
      end

      def find_or_create_by_name(name)
         #some code
      end

   end
end

require_all 'lib'
