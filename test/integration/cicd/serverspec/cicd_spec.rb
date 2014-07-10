require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe 'jtalks::cicd' do
  it 'installs jtalks-cicd package' do
    expect(command('jtalks version')).to return_exit_status(0)
  end
end