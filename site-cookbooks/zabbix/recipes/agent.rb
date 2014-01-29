# -*- coding: utf-8 -*-
#
# Cookbook Name:: zabbix
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash "install-zabbix-agent" do
  code <<-EOC
    yum -y install zabbix-agent zabbix-sender \
      --enablerepo=zabbix,zabbix-non-supported
  EOC
  action :run
  not_if "rpm -q zabbix-agent && rpm -q zabbix-sender"
end

Encoding.default_external = Encoding::UTF_8
template "/etc/zabbix/zabbix_agentd.conf" do
  owner "root"
  group "root"
  mode 0644
end

service "zabbix-agent" do
  supports status: true, restart: true, reload: true
  action   [ :enable, :start ]
  subscribes :restart, "template[/etc/zabbix/zabbix_agentd.conf]"
end
