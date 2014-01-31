# -*- coding: utf-8 -*-
#
# Cookbook Name:: zabbix
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

zabbix_version="2.2.1"
#todo databagへ
zabbix_db_password="kari"

bash "install-zabbix-server-mysql" do
  code <<-EOC
    yum -y install zabbix-server-mysql zabbix-web-mysql zabbix-web-japanese zabbix-get \
      --enablerepo=zabbix,zabbix-non-supported
  EOC
  action  :run
  not_if { File.exists?('/etc/zabbix/zabbix_server.conf') }
end

#/root/.my.cnfでアカウント設定
#todo version
bash "create-zabbix-db" do
  code <<-EOC
    mysql -uroot -e "create database zabbix character set utf8;"
    mysql -uroot -e "grant all privileges on zabbix.* to zabbix@'127.0.0.1' identified by '#{zabbix_db_password}';"
    cd /usr/share/doc/zabbix-server-mysql-#{zabbix_version}/create
    mysql -uroot zabbix < schema.sql
    mysql -uroot zabbix < images.sql
    mysql -uroot zabbix < data.sql
  EOC
  action  :run
  not_if { File.exists?('/var/lib/mysql/zabbix') }
end

Encoding.default_external = Encoding::UTF_8
template "/etc/zabbix/zabbix_server.conf" do
  owner "root"
  group "zabbix"
  mode 0640
end

service "zabbix-server" do
  supports status: true, restart: true, reload: false
  action   [ :enable, :start ]
  subscribes :restart, "template[/etc/zabbix/zabbix_server.conf]"
end
