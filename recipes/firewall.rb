firewall 'ufw' do
  action :enable
end

firewall_rule 'ssh' do
  port     22
  action   :allow
  notifies :enable, 'firewall[ufw]'
end

firewall_rule 'http' do
  port     80
  protocol :tcp
  position 1
  action   :allow
end

firewall_rule 'mysql' do
  port      3306
  direction :in
  interface 'eth0'
  action    :deny
end