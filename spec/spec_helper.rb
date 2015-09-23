$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'breaker/dalli/repo'
require 'dalli'
require 'active_support'
require 'active_support/cache/dalli_store'
require 'breaker'

module Rails
  def self.cache
    @cache ||= ActiveSupport::Cache::DalliStore.new('localhost')
  end
end
Breaker.repo = Breaker::Dalli::Repo.new
