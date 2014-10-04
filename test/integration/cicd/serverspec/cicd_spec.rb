require 'serverspec'
set :backend, :exec

describe 'jtalks::cicd' do
  it 'installs jtalks-cicd package' do
    expect(command('jtalks version')).to return_exit_status(0)
  end
end