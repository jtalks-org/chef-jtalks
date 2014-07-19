require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe 'jtalks::jcommune' do
  describe file('/home/jcommune/tomcat/conf/server.xml') do
    its(:content) { should include '9000' }
    its(:content) { should include '8000' }
  end
  describe user('jcommune') do
    it { should exist }
    it { should have_home_directory '/home/jcommune' }
    it { should have_login_shell '/bin/bash' }
  end
  describe file('/home/jcommune/apache-tomcat-8.0.9') do
    it { should be_directory }
    it { should be_owned_by 'jcommune' }
    it { should be_mode 755 }
  end
  describe file('/home/jcommune/tomcat') do
    it { should be_linked_to '/home/jcommune/apache-tomcat-8.0.9' }
    it { should be_owned_by 'jcommune' }
  end
  describe file('/home/jcommune') do
    it {should be_mode 700}
  end
  describe file('/home/jcommune/.jtalks/environments/chef') do
    it {should be_mode 700}
    it {should be_owned_by 'jcommune'}
  end
  describe file('/home/jcommune/.jtalks/environments/chef/jcommune.xml') do
    it { should be_owned_by 'jcommune' }
    it { should be_mode 600 }
    its(:content) { should include 'name="EH_CACHE_CONFIG" value="/home/jcommune/tomcat/conf/jcommune.ehcache.xml"' }
    its(:content) { should include 'name="JCOMMUNE_DB_USER" value="jcommune"' }
    its(:content) { should include 'name="JCOMMUNE_DB_PASSWORD" value="jcommune"' }
    its(:content) { should include 'value="jdbc:mysql://localhost/jcommune?characterEncoding=UTF-8"' }

    its(:content) { should include 'name="SMTP_PORT" value="25"' }
    its(:content) { should include 'name="JCOMMUNE_PLUGIN_FOLDER" value="/home/jcommune/.jtalks/plugins/chef"' }
    its(:content) { should include 'name="spring.profiles.active" value="performance"' }
  end

  it('creates jcommune db user') do
    expect(command("mysql -ujcommune -pjcommune -e 'select 1 from dual;'")).to return_exit_status(0)
  end

  it('creates jcommune db with permissions granted to jcommune user') do
    expect(command('mysqldump -ujcommune -pjcommune jcommune > /dev/null')).to return_exit_status(0)
  end

  it('sets x flag to .sh scripts in tomcat dir') do
    tomcat_bin = '/home/jcommune/tomcat/bin'
    expect(file("#{tomcat_bin}/startup.sh")).to be_mode 744
    expect(file("#{tomcat_bin}/shutdown.sh")).to be_mode 744
    expect(file("#{tomcat_bin}/catalina.sh")).to be_mode 744
  end
end