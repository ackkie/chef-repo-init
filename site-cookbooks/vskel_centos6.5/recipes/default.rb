#
# Cookbook Name:: vskel_centos6.5
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#kickstart後のpostinstall調整分
%w{xterm git lftp nmap system-config-lvm}.each do |pkg|
  package pkg do
    action :install
  end
end

#yum系
%w{yum-utils yum-plugin-downloadonly yum-plugin-versionlock yum-plugin-security}.each do |pkg|
  package pkg do
    action :install
  end
end

%w{dstat sysstat}.each do |pkg|
  package pkg do
    action :install
  end
end
