# -*- coding: utf-8 -*-
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
  not_if  "rpm -q mysql-server"
end

file "/var/log/mysql-slow.log" do
  owner "mysql"
  group "mysql"
  mode 0640
  action :create_if_missing
end

Encoding.default_external = Encoding::UTF_8
template "my.cnf" do
  path "/etc/my.cnf"
  owner "root"
  group "root"
  mode 0644
#  notifies :restart, 'service[mysqld]'
end

#サービススタート
execute "mysql-server start" do
  not_if  { File.exists?('/var/run/mysqld') }
# sleepをいれておかないとtestdbができないため
  command "service mysqld start && sleep 30"
  action  :run
end

#todo
root_password="kari"

script "mysql_secure_installation" do
  interpreter 'bash'
  user "root"
  only_if { File.exists?('/var/lib/mysql/test') }
  code <<-EOS
    mysql -u root --password='' -h 127.0.0.1 -e "DELETE FROM mysql.user WHERE User='';"
    mysql -u root --password='' -h 127.0.0.1 -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
    mysql -u root --password='' -h 127.0.0.1 -e "DROP DATABASE test;"
    mysql -u root --password='' -h 127.0.0.1 -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';"
    mysql -u root --password='' -h 127.0.0.1 -e "UPDATE mysql.user SET Password=PASSWORD('#{root_password}') WHERE User='root'"
    mysql -u root --password='' -h 127.0.0.1 -e "FLUSH PRIVILEGES;"
  EOS
end

template "/root/.my.cnf" do
  source "dotmy.cnf.erb"
  owner "root"
  group "root"
  mode 0600
end

service "mysqld" do
  supports status: true, restart: true, reload: false
  action   [ :enable, :start ]
  subscribes :restart, "template[my.cnf]"
end
