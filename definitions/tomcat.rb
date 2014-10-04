define :tomcat, :owner => 'root', :owner_group => nil, :port => 8080, :shutdown_port => 8001 do
  if params[:owner_group] == nil
    params[:owner_group] = params[:user]
  end
  catalina_sh = "#{params[:name]}/tomcat/bin/catalina.sh"
  webapps = "#{params[:name]}/tomcat/webapps"

  result_folder_name = "apache-tomcat-#{node[:tomcat][:version]}"
  ark result_folder_name do
    url node[:tomcat][:download_url]
    path params[:name]
    owner params[:owner]
    action :put
  end
  execute 'chmod u+x startup.sh catalina.sh shutdown.sh' do
    cwd "#{params[:name]}/#{result_folder_name}/bin"
    user params[:owner]
  end
  execute "chmod 755 #{result_folder_name}" do
    cwd params[:name]
    user params[:owner]
  end
  link "#{params[:name]}/tomcat" do
    to "#{params[:name]}/#{result_folder_name}"
    owner params[:owner]
    group params[:owner_group]
  end
  execute 'chmod 755 tomcat' do
    cwd params[:name]
    user params[:owner]
  end
  template "#{params[:name]}/tomcat/conf/server.xml" do
    source 'server.xml.erb'
    mode '0644'
    owner params[:owner]
    group params[:owner_group]
    variables({
                  :port => params[:port],
                  :shutdown_port => params[:shutdown_port]})
  end
  execute 'tomcat should use faster random generator' do
    command "echo 'CATALINA_OPTS=\"-Djava.security.egd=file:/dev/./urandom $CATALINA_OPTS\"' >> #{catalina_sh}"
    not_if { File.readlines(catalina_sh).grep(/java.security.egd/).any? }
  end
  %w[examples docs ROOT host-manager manager].each do |folder|
    directory "#{webapps}/#{folder}" do
      recursive true
      action :delete
    end
  end
end