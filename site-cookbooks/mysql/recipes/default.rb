# -*- coding: utf-8 -*-
#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#もっとよいかきかたがあるはず
execute "mysql-server-install" do
  command "yum -y install mysql-server --enablerepo=remi"
  action  :run
  not_if  { File.exists?('/etc/rc.d/init.d/mysqld') }
end

# ここで/etc/my.cnfを設定

#サービススタート
execute "mysql-server start" do
  not_if  { File.exists?('/var/run/mysqld') }
  command "service mysqld start"
  action  :run
end

script "mysql_secure_installation" do
  interpreter 'bash'
  user "root"
  only_if { File.exists?('/var/lib/mysql/test') }
  code <<-EOS
    mysql -u root -e "DELETE FROM mysql.user WHERE User='';"
    mysql -u root -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
    mysql -u root -e "DROP DATABASE test;"
    mysql -u root -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';"
    mysql -u root -e "UPDATE mysql.user SET Password=PASSWORD('hoge') WHERE User='root'"
    mysql -u root -e "FLUSH PRIVILEGES;"
  EOS
end

service "mysqld" do
  supports status: true, restart: true, reload: true
  action   [ :enable, :start ]
end
