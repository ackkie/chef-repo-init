#
# Cookbook Name:: mysql
# Recipe:: mysql_secure_installation.rb
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#execute or script or bash?
script "secure_installation" do
  interpreter 'bash'
  user "root"
  only_if "mysql -u root -e 'show databases'"
  code <<-EOS
    mysql -u root -e "DELETE FROM mysql.user WHERE User='';"
    mysql -u root -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
    mysql -u root -e "DROP DATABASE test;"
    mysql -u root -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';"
    mysql -u root -e "UPDATE mysql.user SET Password=PASSWORD('hoge') WHERE User='root'"
    mysql -u root -e "FLUSH PRIVILEGES;"
  EOS
end
