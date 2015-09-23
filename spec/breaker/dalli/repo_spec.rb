require 'spec_helper'

describe Breaker::Dalli::Repo do
  let(:fuse) { double(:fuse) }

  it 'has a version number' do
    expect(Breaker::Dalli::VERSION).not_to be nil
  end

  it 'has a store' do
    expect(subject.store).to be_a Breaker::Dalli::Store
  end

  it 'keeps a count' do
    expect(subject.store).to receive(:length)
    subject.count
  end

  it 'can find the first fuse in the store' do
    expect(subject.store).to receive(:first)
    subject.first
  end

  it 'can create/update a fuse' do
    attrs = double(:attrs)
    allow(attrs).to receive(:fetch).with(:name) { fuse }
    expect(subject.store).to receive(:find) { fuse }
    expect(fuse).to receive(:update).with(attrs)
    subject.upsert(attrs)
  end
end

describe Breaker::Dalli::Repo do
  subject { Breaker::Dalli::Repo }

  it 'has a config' do
    expect(subject.config).to be_a Hash
  end
end

describe Breaker do
  it 'has a dalli repo' do
    expect(subject.repo).to be_a Breaker::Dalli::Repo
  end
end
