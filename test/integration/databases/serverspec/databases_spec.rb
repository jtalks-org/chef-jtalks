require 'serverspec'
set :backend, :exec

describe 'jtalks::databases' do
  describe command("mysql -ujcommune -pjcommune -e 'select 1 from dual;'") do
    its(:exit_status) { should eq 0 }
  end

  describe command('mysqldump -ujcommune -pjcommune jcommune > /dev/null') do
    its(:exit_status) {should eq 0}
  end

end