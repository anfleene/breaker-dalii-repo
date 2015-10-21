require 'spec_helper'

describe Breaker::RailsCache::Repo do
  let(:fuse) { double(:fuse) }

  it 'has a version number' do
    expect(Breaker::RailsCache::VERSION).not_to be nil
  end

  it 'has a store' do
    expect(subject.store).to be_a Breaker::RailsCache::Store
  end

  it 'can create/update a fuse' do
    attrs = double(:attrs)
    allow(attrs).to receive(:fetch).with(:name) { fuse }
    expect(subject.store).to receive(:find) { fuse }
    expect(fuse).to receive(:update).with(attrs)
    subject.upsert(attrs)
  end
end

describe Breaker::RailsCache::Repo do
  subject { Breaker::RailsCache::Repo }

  it 'has a config' do
    expect(subject.config).to be_a Hash
  end
end

describe Breaker do
  it 'has a rails cache repo' do
    expect(subject.repo).to be_a Breaker::RailsCache::Repo
  end
end
