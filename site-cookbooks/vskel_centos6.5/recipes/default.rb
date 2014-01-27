# -*- coding: utf-8 -*-
#
# Cookbook Name:: vskel_centos6.5
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#
#yum系
#

%w{
yum-plugin-downloadonly
yum-plugin-security
yum-plugin-versionlock
yum-utils
}.each do |pkg|
  package pkg do
    action :install
  end
end

#
# SELinux関連
#
# policycoreutils-gui system-config-selinuxが入っている
# policycoreutils-python semanageが入っている
# setools-console sesearchが入っている
# setroubleshoot avclogをsyslogやメール出力
# setroubleshoot-server avclogをsyslogやメール出力
# star SELinuxアーカイブ

%w{
policycoreutils-gui
policycoreutils-python
setools-console
setroubleshoot
setroubleshoot-server
star
}.each do |pkg|
  package pkg do
    action :install
  end
end

%w{redhat-lsb}.each do |pkg|
  package pkg do
    action :install
  end
end

%w{dstat sysstat}.each do |pkg|
  package pkg do
    action :install
  end
end

%w{
expect
git
lftp
nmap
screen
subversion
tree
xterm
}.each do |pkg|
  package pkg do
    action :install
  end
end

#
# その他
#
# freenx nxserver
# net-snmp
# net-snmp-utils
# net-snmp-perl traptoemailに必要
# webalizer apacheログを見る
# nfs-utils NFSクライアントで必要
# nfs4-acl-tools NFSクライアントで必要

%w{
emacs
firefox
freenx
ipmitool
net-snmp
net-snmp-perl
net-snmp-utils
nfs-utils
nfs4-acl-tools
system-config-lvm
webalizer
}.each do |pkg|
  package pkg do
    action :install
  end
end

# デフォルト無効サービス停止

# NetworkManager off サーバなら停止
# acpid on 仮想ゲストで必要？
# avahi-daemon off mac形式
# bluetooth off
# cpuspeed off 仮想では不要
# cups off
# haldaemon off 'mouse,keyboard,usb等プラグ&プレイ使わなければ不要'
# ip6tables off
# iscsi off
# iscsid off
# kdump off メモリを食うため停止
# lm_sensors off ipmiでよい
# mdmonitor off 'For Software Raid'
# qpidd off 'MQ現状小規模では不要'
# smartd off 監視対象がなければ不要
# nfslock off NFSを使用使用しなければ不要

%w{
abrt-ccpp
abrtd
autofs
avahi-daemon
bluetooth
cpuspeed
cups
freenx-server
haldaemon
ip6tables
iscsi
iscsid
kdump
lm_sensors
mdmonitor
psacct
qpidd
restorecond
smartd
nfslock
}.each { |name|
  service name do
    ignore_failure true
    action [:disable, :stop]
  end
}
