require 'spec_helper'

describe Breaker::RailsCache::Fuse do
  subject { Breaker::RailsCache::Fuse.new(:test) }

  it 'uses the Repo config has defaults' do
    expect(subject.defaults).to eq(Breaker::RailsCache::Repo.config)
  end

  it 'sets default values' do
    expect(subject.state).to eq(:closed)
    expect(subject.failure_threshold).to eq(10)
    expect(subject.timeout).to eq(5)
    expect(subject.half_open_timeout).to eq(0.5)
    expect(subject.failure_count).to eq(0)
    expect(subject.retry_timeout).to eq(60)
  end

  it 'can be updated' do
    subject.update(state: :open)
    expect(subject.state).to eq(:open)
    subject.state = :closed
  end

  it 'can detect equality based on fuse name' do
    expect(subject).to eq(Breaker::RailsCache::Fuse.new(:test))
  end

  it 'sets a value using rails cache' do
    subject
    expect(Rails.cache).to receive(:write).with("BREAKER_test_state", :closed, {})
    subject.set_value(:state, :closed)
  end

  it 'gets a value using rails cache' do
    subject
    expect(Rails.cache).to receive(:read).with("BREAKER_test_state")
    subject.get_value(:state)
  end

  it 'increment a value in rails cache' do
    subject
    expect(Rails.cache).to receive(:increment).with("BREAKER_test_failure_count", 1, { :expires_in => 300, :initial => 1})
    subject.inc_value(:failure_count, 1)
  end

  it 'generates a key name' do
    expect(subject.key_name(:test)).to eq("BREAKER_test_test")
  end

  it 'can set reset the failure count to the initial value' do
    subject.failure_count = 1
    subject.failure_count = 1
    expect(subject.failure_count).to eq(2)
    subject.failure_count = 0
    expect(subject.failure_count).to eq(1)
  end

  it 'can increment the failure count' do
    subject.failure_count = 2
    expect(subject.failure_count).to eq(1)
    subject.failure_count = 0
  end
end
