require "breaker/rails_cache/version"
require "breaker/rails_cache/fuse"
require "breaker/rails_cache/store"

module Breaker
  module RailsCache
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
          half_open_timeout: 0.5,
          breaker_error_class: Timeout::Error,
          failure_count: 0,
          failure_count_ttl: 300,
          state: :closed,
        }
      end

      def upsert(attributes)
        fuse = store.find attributes.fetch(:name)
        fuse.update attributes
        fuse
      end
    end
  end
end
