include_recipe 'database::mysql'

owner = node[:jtalks][:antarcticle][:user][:name]
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
  port node[:tomcat][:instances][:antarcticle][:port]
  shutdown_port node[:tomcat][:instances][:antarcticle][:shutdown_port]
end

root_connection_info = {
    :host     => 'localhost',
    :username => 'root',
    :password => node[:mysql][:server_root_password]
}

mysql_database node[:jtalks][:antarcticle][:db][:name] do
  connection root_connection_info
  encoding 'utf8'
  action :create
end

mysql_database_user node[:jtalks][:antarcticle][:db][:name] do
  connection root_connection_info
  password node[:jtalks][:antarcticle][:db][:password]
  database_name node[:jtalks][:antarcticle][:db][:name]
  privileges [:all]
  action [:create, :grant]
end

antarcticle_configs_dir = "#{node[:jtalks][:antarcticle][:jtalks_configs_folder]}/environments/#{node[:jtalks][:env_name]}"

directory node[:jtalks][:antarcticle][:jtalks_configs_folder] do
  owner owner
  group owner
  mode '00700'
  action :create
end

directory antarcticle_configs_dir do
  owner owner
  group owner
  recursive true
  mode '00700'
  action :create
end

directory "#{node[:jtalks][:antarcticle][:jtalks_configs_folder]}/plugins/chef" do
  owner owner
  group owner
  recursive true
  mode '00700'
  action :create
end

template "#{antarcticle_configs_dir}/antarcticle.xml" do
  source 'jtalks/antarcticle.xml.erb'
  mode '0600'
  owner owner
  variables({
                :tomcat_location => node[:tomcat][:instances][:antarcticle][:base],
                :db_name => node[:jtalks][:antarcticle][:db][:name],
                :db_user => node[:jtalks][:antarcticle][:db][:user],
                :db_password => node[:jtalks][:antarcticle][:db][:password],
                :smtp_host => node[:jtalks][:mail][:smtp_host],
                :smtp_port => node[:jtalks][:mail][:smtp_port],
                :mailbox_username => node[:jtalks][:mail][:antarcticle][:mailbox_username],
                :mailbox_password => node[:jtalks][:mail][:antarcticle][:mailbox_password],
                :plugin_folder => node[:jtalks][:antarcticle][:plugin_folder],
                :spring_profiles => node[:jtalks][:antarcticle][:spring_profiles]})
end

template "#{node[:jtalks][:antarcticle][:jtalks_configs_folder]}/environments/global-configuration.cfg" do
  source 'jtalks/global-configuration.cfg.erb'
  mode '0600'
  owner owner
  variables({:tomcat_location => node[:tomcat][:instances][:antarcticle][:base],
             :jtalks_folder => node[:jtalks][:antarcticle][:jtalks_configs_folder]})
end