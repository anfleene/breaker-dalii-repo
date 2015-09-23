require 'spec_helper'

describe Breaker::Dalli::Store do
  it "find creates or finds fuses" do
    expect(subject.find(:test)).to be_a Breaker::Dalli::Fuse
    expect(subject.find(:test)).to eq(subject.find(:test))
  end

  it "knows the number of fuses" do
    subject.find(:test)
    expect(subject.count).to eq(1)
  end

  it "knows the first fuse in the store" do
    fuse = subject.find(:test)
    expect(subject.first).to eq(fuse)
  end
end
