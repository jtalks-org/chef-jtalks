define :jtalks_database do
  app_name = params[:name]
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
    host '%'
    action [:create, :grant]
  end
end