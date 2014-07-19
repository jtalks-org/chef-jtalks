default[:mysql][:client][:version] = '5.5.28'
default[:mysql][:server_root_password] = 'root'
default[:mysql][:server_repl_password] = 'no_replication'
default[:mysql][:server_debian_password] = 'root'

default[:java][:install_flavor] = 'oracle'
default[:java][:oracle][:accept_oracle_download_terms] = true
default[:java][:jdk_version] = 7

default[:jtalks][:jcommune][:db][:name] = 'jcommune'
default[:jtalks][:jcommune][:db][:user] = 'jcommune'
default[:jtalks][:jcommune][:db][:password] = 'jcommune'

default[:jtalks][:jcommune][:user][:name] = 'jcommune'

default[:tomcat][:major_version] = '8'
default[:tomcat][:minor_version] = '0.9'
default[:tomcat][:version] = "#{node[:tomcat][:major_version]}.#{node[:tomcat][:minor_version]}"
default[:tomcat][:download_url] = "http://apache-mirror.rbc.ru/pub/apache/tomcat/tomcat-#{node[:tomcat][:major_version]}/" +
    "v#{node[:tomcat][:version]}/bin/apache-tomcat-#{node[:tomcat][:version]}.zip"
default[:tomcat][:instances][:jcommune][:base] = "/home/#{node[:jtalks][:jcommune][:user][:name]}"
default[:tomcat][:instances][:jcommune][:port] = 9000
default[:tomcat][:instances][:jcommune][:shutdown_port] = 8000

default[:nginx][:forum_site] = 'jcommune'