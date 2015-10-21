require 'spec_helper'

describe Breaker::RailsCache::Store do
  it "find creates or finds fuses" do
    expect(subject.find(:test)).to be_a Breaker::RailsCache::Fuse
    expect(subject.find(:test)).to eq(subject.find(:test))
  end

  it "Running find multiple times only creates one Fuse" do
    expect(subject.find(:test)).to eq(subject.find(:test))
  end
end
