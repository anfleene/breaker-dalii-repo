require 'spec_helper'

describe Breaker::Dalli::Repo do
  it 'has a version number' do
    expect(Breaker::Dalli::Repo::VERSION).not_to be nil
  end

end
