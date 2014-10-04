require 'serverspec'
set :backend, :exec

describe 'jtalks::jcommune' do
  describe file('/etc/nginx/sites-available/jcommune') do
    it { be_owned_by 'nginx' }
  end
end