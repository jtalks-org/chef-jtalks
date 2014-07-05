require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe 'jtalks::jcommune' do
  it 'creates jcommune db user' do
    expect(command("mysql -ujcommune -pjcommune -e 'select 1 from dual;'")).to return_exit_status(0)
  end
  it 'creates jcommune db with permissions granted to jcommune user' do
    expect(command('mysqldump -ujcommune -pjcommune jcommune > /dev/null')).to return_exit_status(0)
  end
end
