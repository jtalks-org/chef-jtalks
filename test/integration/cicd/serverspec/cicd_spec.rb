require 'serverspec'
set :backend, :exec

describe 'jtalks::cicd' do
  describe command('jtalks version') do
    its(:exit_status) { should eq 0 }
  end
end