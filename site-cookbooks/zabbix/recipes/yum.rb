# -*- coding: utf-8 -*-
#
# Cookbook Name:: zabbix
# Recipe:: yum
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "install-zabbix-repo" do
  command "rpm -ivh http://repo.zabbix.com/zabbix/2.2/rhel/6/x86_64/zabbix-release-2.2-1.el6.noarch.rpm"
  action  :run
  not_if  { File.exists?('/etc/yum.repos.d/zabbix.repo') }
end

template "/etc/yum.repos.d/zabbix.repo" do
  source "zabbix.repo.erb"
  owner "root"
  group "root"
  mode 0644
end
