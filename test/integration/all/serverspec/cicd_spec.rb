require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe 'jtalks::cicd' do
  it 'creates jcommune user with home dir' do
    expect(user('jcommune')).to exist
    expect(user('jcommune')).to have_home_directory '/home/jcommune'
    expect(file('/home/jcommune')).to be_directory
    expect(file('/home/jcommune')).to be_owned_by 'jcommune'
    expect(file('/home/jcommune')).to be_mode 700
  end

  it 'installs jtalks-cicd package' do
    expect(command('jtalks version')).to return_exit_status(0)
  end
end