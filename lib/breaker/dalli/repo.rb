require "breaker/dalli/version"
require "breaker/dalli/fuse"
require "breaker/dalli/store"

module Breaker
  module Dalli
    class Repo

      attr_reader :store

      def initialize
        @store = Store.new
      end

      def self.config
        {
          failure_threshold: 10,
          retry_timeout: 60,
          timeout: 5,
          state: :closed,
          failure_count: 0,
        }
      end

      def upsert(attributes)
        fuse = store.find attributes.fetch(:name)
        fuse.update attributes
      end

      def count
        store.length
      end

      def first
        store.first
      end
    end
  end
end
