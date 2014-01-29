# -*- coding: utf-8 -*-
#
# Cookbook Name:: zabbix
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash "install-zabbix-server-mysql" do
  code <<-EOC
    yum -y install zabbix-server-mysql zabbix-web-mysql zabbix-web-japanese zabbix-get \
      --enablerepo=zabbix,zabbix-non-supported
  EOC
  action  :run
  not_if { File.exists?('/etc/zabbix/zabbix_server.conf') }
end

Encoding.default_external = Encoding::UTF_8
template "/etc/zabbix/zabbix_server.conf" do
  owner "root"
  group "zabbix"
  mode 0640
end

service "zabbix-server" do
  supports status: true, restart: true, reload: true
  action   [ :enable, :start ]
  subscribes :restart, "template[/etc/zabbix/zabbix_server.conf]"
end