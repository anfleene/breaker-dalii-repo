$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'breaker/rails_cache/repo'
require 'active_support'
require 'breaker'

module Rails
  def self.cache
    @cache ||= ActiveSupport::Cache::MemoryStore.new
  end
end
Breaker.repo = Breaker::RailsCache::Repo.new
