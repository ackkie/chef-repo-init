# -*- coding: undecided -*-
#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "mysql-server-install" do
  command "yum -y install mysql-server --enablerepo=remi"
  action  :run
  not_if  { File.exists?('/var/lib/mysql') }
end

#もっとよいかきかたがあるはず
execute "service start" do
  command "service start"
  action  :run
  not_if  { File.exists?('/var/lib/mysql') }
end

execute "mysql-install-db" do
  command "mysql_secure_installation"
  action  :run
  not_if  { File.exists?('/var/lib/mysql/mysql/user.frm') }
end

service "mysqld" do
  supports status: true, restart: true, reload: true
  action   [ :enable, :start ]
end

