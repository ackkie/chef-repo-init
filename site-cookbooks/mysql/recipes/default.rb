#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "mysql-install" do
  command "yum -y --enablerepo=remi mysql-server"
  action  :run
  not_if  { File.exists?('/var/lib/mysql') }
end

service "mysqld" do
  supports status: true, restart: true, reload: true
  action   [ :enable, :start ]
end

execute "mysql-install" do
  command "yum -y --enablerepo=remi mysql-server"
  action  :run
  not_if  { File.exists?('/var/lib/mysql') }
end

