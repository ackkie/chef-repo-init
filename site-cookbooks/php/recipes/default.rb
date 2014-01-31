# -*- coding: utf-8 -*-
#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


%w{
php
}.each do |pkg|
  package pkg do
    action :install
  end
end

#todo service 再起動
Encoding.default_external = Encoding::UTF_8
template "/etc/php.ini" do
  owner "root"
  group "root"
  mode 0644
#  notifies :restart, 'service[apache]'
end
