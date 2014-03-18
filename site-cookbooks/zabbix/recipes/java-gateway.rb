# -*- coding: utf-8 -*-
#
# Cookbook Name:: zabbix
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash "install-zabbix-java-gateway" do
  code <<-EOC
    yum -y install zabbix-java-gateway \
      --enablerepo=zabbix,zabbix-non-supported
  EOC
  action :run
  not_if "rpm -q zabbix-java-gateway"
end

service "zabbix-java-gateway" do
  supports status: true, restart: true, reload: false
  action   [ :enable, :start ]
end
