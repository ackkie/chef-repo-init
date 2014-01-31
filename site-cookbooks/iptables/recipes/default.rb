#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "iptables" do
  action :install
end

template "/etc/sysconfig/iptables" do
  source "easy.erb"
  owner "root"
  group "root"
  mode 0600
end

service "iptables" do
  supports status: true, restart: true, reload: false
  action   [ :enable, :start ]
  subscribes :restart, "template[/etc/sysconfig/iptables]"
end
