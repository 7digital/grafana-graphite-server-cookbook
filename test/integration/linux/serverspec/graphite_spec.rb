require 'serverspec'
set :backend, :exec

describe 'graphite' do
  describe docker_image('hopsoft/graphite-statsd') do
    it { should exist }
  end
end
