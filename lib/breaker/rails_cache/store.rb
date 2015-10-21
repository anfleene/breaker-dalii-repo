module Breaker
  module RailsCache
    class Store
      def initialize
        @store = Set.new
      end

      def find(name)
        Fuse.new(name)
      end
    end
  end
end



