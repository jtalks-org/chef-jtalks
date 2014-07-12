define :tomcat, :owner => 'root', :owner_group => nil, :port => 8080, :shutdown_port => 8001 do
  if params[:owner_group] == nil
    params[:owner_group] = params[:user]
  end

  result_folder_name = "apache-tomcat-#{node[:tomcat][:version]}"
  ark result_folder_name do
    url node[:tomcat][:download_url]
    path params[:name]
    owner params[:owner]
    action :put
  end
  execute "chmod u+x startup.sh catalina.sh shutdown.sh" do
    cwd "#{params[:name]}/#{result_folder_name}/bin"
    user params[:owner]
  end
  execute "chmod 755 #{result_folder_name} tomcat" do
    cwd params[:name]
    user params[:owner]
  end
  link "#{params[:name]}/tomcat" do
    to "#{params[:name]}/#{result_folder_name}"
    owner params[:owner]
    group params[:owner_group]
  end
end