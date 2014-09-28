define :jtalks_webapp do
  app_name = params[:name]
  owner = node[:jtalks][app_name][:user][:name]
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
    port node[:tomcat][:instances][app_name][:port]
    shutdown_port node[:tomcat][:instances][app_name][:shutdown_port]
  end

  root_connection_info = {
      :host     => 'localhost',
      :username => 'root',
      :password => node[:mysql][:server_root_password]
  }

  mysql_database node[:jtalks][app_name][:db][:name] do
    connection root_connection_info
    encoding 'utf8'
    action :create
  end

  mysql_database_user node[:jtalks][app_name][:db][:name] do
    connection root_connection_info
    password node[:jtalks][app_name][:db][:password]
    database_name node[:jtalks][app_name][:db][:name]
    privileges [:all]
    action [:create, :grant]
  end

  app_configs_dir = "#{node[:jtalks][app_name][:jtalks_configs_folder]}/environments/#{node[:jtalks][:env_name]}"

  directory node[:jtalks][app_name][:jtalks_configs_folder] do
    owner owner
    group owner
    mode '00700'
    action :create
  end

  directory app_configs_dir do
    owner owner
    group owner
    recursive true
    mode '00700'
    action :create
  end

  directory "#{node[:jtalks][app_name][:jtalks_configs_folder]}/plugins/chef" do
    owner owner
    group owner
    recursive true
    mode '00700'
    action :create
  end

  template "#{app_configs_dir}/#{app_name}.xml" do
    source "jtalks/#{app_name}.xml.erb"
    mode '0600'
    owner owner
    variables({
                  :tomcat_location => node[:tomcat][:instances][app_name][:base],
                  :db_url => node[:jtalks][app_name][:db][:url],
                  :db_user => node[:jtalks][app_name][:db][:user],
                  :db_password => node[:jtalks][app_name][:db][:password],
                  :smtp_host => node[:jtalks][:mail][:smtp_host],
                  :smtp_port => node[:jtalks][:mail][:smtp_port],
                  :mailbox_username => node[:jtalks][:mail][app_name][:mailbox_username],
                  :mailbox_password => node[:jtalks][:mail][app_name][:mailbox_password],
                  :plugin_folder => node[:jtalks][app_name][:plugin_folder],
                  :poulpe_url => node[:jtalks][app_name][:poulpe_url],
                  :spring_profiles => node[:jtalks][app_name][:spring_profiles]})
  end

  template "#{node[:jtalks][app_name][:jtalks_configs_folder]}/environments/global-configuration.cfg" do
    source 'jtalks/global-configuration.cfg.erb'
    mode '0600'
    owner owner
    variables({:tomcat_location => node[:tomcat][:instances][app_name][:base],
               :jtalks_folder => node[:jtalks][app_name][:jtalks_configs_folder]})
  end


  cookbook_file "#{node[:tomcat][:instances][app_name][:base]}/conf/#{app_name}.ehcache.xml" do
    source "jtalks/#{app_name}.ehcache.xml"
    owner owner
    group owner
    mode "0644"
    ignore_failure true
  end
end