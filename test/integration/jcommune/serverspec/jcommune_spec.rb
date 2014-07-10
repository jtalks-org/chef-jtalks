require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe 'jtalks::jcommune' do
  it 'creates os jcommune user with home dir' do
    expect(user('jcommune')).to exist
    expect(user('jcommune')).to have_home_directory '/home/jcommune'
    expect(user('jcommune')).to have_home_directory '/home/jcommune'
    expect(file('/home/jcommune')).to be_mode 700
  end

  it 'creates jcommune db user' do
    expect(command("mysql -ujcommune -pjcommune -e 'select 1 from dual;'")).to return_exit_status(0)
  end

  it 'creates jcommune db with permissions granted to jcommune user' do
    expect(command('mysqldump -ujcommune -pjcommune jcommune > /dev/null')).to return_exit_status(0)
  end

  it 'installs personal tomcat into user home dir' do
    tomcat_path = '/home/jcommune/apache-tomcat-8.0.9'
    expect(file(tomcat_path)).to be_directory
    expect(file(tomcat_path)).to be_owned_by 'jcommune'
    # expect(file(tomcat_path)).to be_mode 700
  end

  it 'creates symlinks to the personal tomcat' do
    expect(file('/home/jcommune/tomcat')).to be_linked_to '/home/jcommune/apache-tomcat-8.0.9'
    expect(file('/home/jcommune/tomcat')).to be_owned_by 'jcommune'
  end
end
