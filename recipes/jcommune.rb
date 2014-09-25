include_recipe 'database::mysql'

owner = node[:jtalks][:jcommune][:user][:name]
home_dir = "/home/#{owner}"


user owner do
  shell '/bin/bash'
  action :create
end

directory home_dir do
  owner owner
  mode 00700
  action :create
end

tomcat home_dir do
  owner owner
  port node[:tomcat][:instances][:jcommune][:port]
  shutdown_port node[:tomcat][:instances][:jcommune][:shutdown_port]
end

root_connection_info = {
    :host     => 'localhost',
    :username => 'root',
    :password => node[:mysql][:server_root_password]
}

mysql_database node[:jtalks][:jcommune][:db][:name] do
  connection root_connection_info
  encoding 'utf8'
  action :create
end

mysql_database_user node[:jtalks][:jcommune][:db][:name] do
  connection root_connection_info
  password node[:jtalks][:jcommune][:db][:password]
  database_name node[:jtalks][:jcommune][:db][:name]
  privileges [:all]
  action [:create, :grant]
end

jcommune_configs_dir = "#{node[:jtalks][:jcommune][:jtalks_configs_folder]}/environments/#{node[:jtalks][:env_name]}"

directory node[:jtalks][:jcommune][:jtalks_configs_folder] do
  owner owner
  group owner
  mode '00700'
  action :create
end

directory jcommune_configs_dir do
  owner owner
  group owner
  recursive true
  mode '00700'
  action :create
end

template "#{jcommune_configs_dir}/jcommune.xml" do
  source 'jtalks/jcommune.xml.erb'
  mode '0600'
  owner owner
  variables({
                :tomcat_location => node[:tomcat][:instances][:jcommune][:base],
                :db_name => node[:jtalks][:jcommune][:db][:name],
                :db_user => node[:jtalks][:jcommune][:db][:user],
                :db_password => node[:jtalks][:jcommune][:db][:password],
                :smtp_host => node[:jtalks][:mail][:smtp_host],
                :smtp_port => node[:jtalks][:mail][:smtp_port],
                :mailbox_username => node[:jtalks][:mail][:jcommune][:mailbox_username],
                :mailbox_password => node[:jtalks][:mail][:jcommune][:mailbox_password],
                :plugin_folder => node[:jtalks][:jcommune][:plugin_folder],
                :spring_profiles => node[:jtalks][:jcommune][:spring_profiles]})
end