#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package_name='httpd'

%w{
httpd
}.each do |pkg|
  package pkg do
    action :install
  end
end

#service "apache" do
#  supports status: true, restart: true, reload: true
#  action   [ :enable, :start ]
#end
#
case node[:platform]
when "centos"
  service "httpd" do
    supports status: true, restart: true, reload: true
    action   [ :enable, :start ]
  end
when "ubuntu","debian"
  service "httpd" do
    supports status: true, restart: true, reload: true
    action   [ :enable, :start ]
  end
end


