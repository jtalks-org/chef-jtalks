include_recipe "database::mysql"

user node[:jtalks][:jcommune][:user][:name] do
  action :create
end

directory "/home/#{node[:jtalks][:jcommune][:user][:name]}" do
  owner node[:jtalks][:jcommune][:user][:name]
  mode 00700
  action :create
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