default[:jtalks][:env_name] = 'chef'

default[:mysql][:client][:version] = '5.5.28'
default[:mysql][:server_root_password] = 'root'
default[:mysql][:server_repl_password] = 'no_replication'
default[:mysql][:server_debian_password] = 'root'

default[:java][:install_flavor] = 'oracle'
default[:java][:oracle][:accept_oracle_download_terms] = true
default[:java][:jdk_version] = 7

default[:tomcat][:major_version] = '8'
default[:tomcat][:minor_version] = '0.15'
default[:tomcat][:version] = "#{node[:tomcat][:major_version]}.#{node[:tomcat][:minor_version]}"
default[:tomcat][:download_url] = "http://apache-mirror.rbc.ru/pub/apache/tomcat/tomcat-#{node[:tomcat][:major_version]}/" +
    "v#{node[:tomcat][:version]}/bin/apache-tomcat-#{node[:tomcat][:version]}.zip"

default[:jtalks][:mail][:smtp_host] = 'smtp.mail.ru'
default[:jtalks][:mail][:smtp_port] = 465

default[:jtalks][:db][:host] = 'localhost'

# jcommune
# OS
default[:jtalks][:jcommune][:user][:name] = 'jcommune'
default[:jtalks][:jcommune][:user][:home_dir] = "/home/#{node[:jtalks][:jcommune][:user][:name]}"
# DB
default[:jtalks][:jcommune][:db][:name] = node[:jtalks][:jcommune][:user][:name]
default[:jtalks][:jcommune][:db][:url] = "jdbc:mysql://#{node[:jtalks][:db][:host]}/#{node[:jtalks][:jcommune][:db][:name]}?characterEncoding=UTF-8"
default[:jtalks][:jcommune][:db][:user] = node[:jtalks][:jcommune][:user][:name]
default[:jtalks][:jcommune][:db][:password] = node[:jtalks][:jcommune][:user][:name]
# tomcat
default[:tomcat][:instances][:jcommune][:base] = "#{node[:jtalks][:jcommune][:user][:home_dir]}/tomcat"
default[:tomcat][:instances][:jcommune][:port] = 9000
default[:tomcat][:instances][:jcommune][:shutdown_port] = 8000
# nginx
default[:nginx][:site][:jcommune][:name] = node[:jtalks][:jcommune][:user][:name]
default[:nginx][:site][:jcommune][:host] = 'jcommune'
default[:nginx][:site][:jcommune][:context_path] = '/'
# mail
default[:jtalks][:mail][:jcommune][:mailbox_username] = 'jtalks@inbox.ru'
default[:jtalks][:mail][:jcommune][:mailbox_password] = 'javatalks'
# jtalks configs
default[:jtalks][:jcommune][:jtalks_configs_folder] = "#{node[:jtalks][:jcommune][:user][:home_dir]}/.jtalks"
default[:jtalks][:jcommune][:plugin_folder] = "#{node[:jtalks][:jcommune][:jtalks_configs_folder]}/plugins/#{node[:jtalks][:env_name]}"
default[:jtalks][:jcommune][:spring_profiles] = 'performance'

# Antarcticle
# os
default[:jtalks][:antarcticle][:user][:name] = 'antarcticle'
default[:jtalks][:antarcticle][:user][:home_dir] = "/home/#{node[:jtalks][:antarcticle][:user][:name]}"
# DB
default[:jtalks][:antarcticle][:db][:name] = node[:jtalks][:antarcticle][:user][:name]
default[:jtalks][:antarcticle][:db][:url] = "jdbc:mysql://#{node[:jtalks][:db][:host]}/#{node[:jtalks][:antarcticle][:db][:name]}?characterEncoding=UTF-8"
default[:jtalks][:antarcticle][:db][:user] = node[:jtalks][:antarcticle][:user][:name]
default[:jtalks][:antarcticle][:db][:password] = node[:jtalks][:antarcticle][:db][:name]
# tomcat
default[:tomcat][:instances][:antarcticle][:base] = "#{node[:jtalks][:antarcticle][:user][:home_dir]}/tomcat"
default[:tomcat][:instances][:antarcticle][:port] = 9100
default[:tomcat][:instances][:antarcticle][:shutdown_port] = 8100
# nginx
default[:nginx][:site][:antarcticle][:name] = node[:jtalks][:antarcticle][:user][:name]
default[:nginx][:site][:antarcticle][:host] = 'antarcticle'
default[:nginx][:site][:antarcticle][:context_path] = '/'
# mail
default[:jtalks][:mail][:antarcticle][:mailbox_username] = 'jtalks@inbox.ru'
default[:jtalks][:mail][:antarcticle][:mailbox_password] = 'javatalks'
# jtalks configs
default[:jtalks][:antarcticle][:jtalks_configs_folder] = "#{node[:jtalks][:antarcticle][:user][:home_dir]}/.jtalks"
default[:jtalks][:antarcticle][:poulpe_url] = 'http://localhost:8200'

# Poulpe
# os
default[:jtalks][:poulpe][:user][:name] = 'poulpe'
default[:jtalks][:poulpe][:user][:home_dir] = "/home/#{node[:jtalks][:poulpe][:user][:name]}"
# DB
default[:jtalks][:poulpe][:db][:name] = node[:jtalks][:poulpe][:user][:name]
default[:jtalks][:poulpe][:db][:url] = "jdbc:mysql://#{node[:jtalks][:db][:host]}/#{node[:jtalks][:poulpe][:db][:name]}?characterEncoding=UTF-8"
default[:jtalks][:poulpe][:db][:user] = node[:jtalks][:poulpe][:user][:name]
default[:jtalks][:poulpe][:db][:password] = node[:jtalks][:poulpe][:db][:name]
# tomcat
default[:tomcat][:instances][:poulpe][:base] = "#{node[:jtalks][:poulpe][:user][:home_dir]}/tomcat"
default[:tomcat][:instances][:poulpe][:port] = 9200
default[:tomcat][:instances][:poulpe][:shutdown_port] = 8200
# nginx
default[:nginx][:site][:poulpe][:name] = node[:jtalks][:poulpe][:user][:name]
default[:nginx][:site][:poulpe][:host] = 'poulpe'
default[:nginx][:site][:poulpe][:context_path] = '/'
# mail
default[:jtalks][:mail][:poulpe][:mailbox_username] = 'jtalks@inbox.ru'
default[:jtalks][:mail][:poulpe][:mailbox_password] = 'javatalks'
# jtalks configs
default[:jtalks][:poulpe][:jtalks_configs_folder] = "#{node[:jtalks][:poulpe][:user][:home_dir]}/.jtalks"
