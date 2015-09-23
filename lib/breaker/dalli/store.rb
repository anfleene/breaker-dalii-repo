module Breaker
  module Dalli
    class Store
      def initialize
        @store = Set.new
      end

      def find(name)
        @store.add(Fuse.new(name))
        @store.find{|f| f.name == name }
      end
      def count
        @store.length
      end

      def first
        @store.first
      end
    end
  end
end



