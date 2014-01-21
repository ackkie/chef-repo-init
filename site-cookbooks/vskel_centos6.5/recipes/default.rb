#
# Cookbook Name:: vskel_centos6.5
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{xterm git lftp nmap system-config-lvm}.each do |pkg|
  package pkg do
    action :install
  end
end
