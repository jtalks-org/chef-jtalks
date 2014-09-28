directory node[:nginx][:default_root] do
  owner node[:nginx][:user]
  group node[:nginx][:group]
  mode '0755'
  recursive true
  action :create
end

cookbook_file "#{node[:nginx][:default_root]}/index.html" do
  source 'nginx/maintenance.html'
  owner node[:nginx][:user]
  group node[:nginx][:group]
  mode "0644"
end

node[:nginx][:site].each do |site_attribute_node|
  site = site_attribute_node[1] #hash with values of attribute

  template "#{node[:nginx][:dir]}/sites-available/#{site[:name]}" do
    source 'nginx/site.conf.erb'
    owner node[:nginx][:user]
    group node[:nginx][:group]
    mode '0644'
    destination_port = node[:tomcat][:instances][site[:name]][:port]
    variables({
                  :destination_port => destination_port,
                  :name => site[:name],
                  :host => site[:host],
                  :context_path => site[:context_path]
              })
  end

  nginx_site site[:name] do
    enabled = true
  end

end
