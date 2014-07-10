define :tomcat, :owner => 'root', :owner_group => nil, :port => 8080, :shutdown_port => 8001 do
  if params[:owner_group] == nil
    params[:owner_group] = params[:user]
  end

  result_folder_name = "apache-tomcat-#{node[:tomcat][:version]}"
  ark result_folder_name do
    url node[:tomcat][:download_url]
    path params[:name]
    owner params[:owner]
    mode 700
    action :put
  end

  link "#{params[:name]}/tomcat" do
    to "#{params[:name]}/#{result_folder_name}"
    owner params[:owner]
    group params[:owner_group]
  end
end