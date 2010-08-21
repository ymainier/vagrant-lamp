require_recipe "apt"
require_recipe "apache2"
require_recipe "mysql::server"
require_recipe "php::php5"

# Some neat package (subversion is needed for "subversion" chef ressource)
%w{ php5-xdebug subversion }.each do |a_package|
  package a_package do
    action :upgrade
  end
end

s = "dev-site"
site = {
  :name => s, 
  :host => "www.#{s}.com", 
  :aliases => ["#{s}.com", "dev.#{s}-static.com"]
}

# Configure the development site
web_app site[:name] do
  template "sites.conf.erb"
  server_name site[:host]
  server_aliases site[:aliases]
  docroot "/vagrant/"
end  

# Add site info in /etc/hosts
template "/etc/hosts" do
  source "hosts.conf.erb"
  owner "root"
  group "root"
  mode 0644
  variables(:hosts => [{:ip => "127.0.0.1", :names => [site[:host]] + site[:aliases] }])
end

# Retrieve webgrind for xdebug trace analysis
subversion "Webgrind" do
  repository "http://webgrind.googlecode.com/svn/trunk/"
  revision "HEAD"
  destination "/var/www/webgrind"
  action :sync
end
