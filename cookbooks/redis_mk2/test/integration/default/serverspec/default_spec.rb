require 'spec_helper'

describe 'redis::default' do
  describe service('redis_6379') do
    it { should be_running }
  end
end
