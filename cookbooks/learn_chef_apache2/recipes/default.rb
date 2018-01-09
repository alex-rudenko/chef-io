#
# Cookbook Name:: learn_chef_apache2
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
apt_update 'Update the apt cache daily' do
  frequency 86_400
  action :periodic
end

package 'apache2'

package 'mtr-tiny'

service 'apache2' do
  supports status: true
  action [:enable, :start]
end

group 'web_admin'
group 'db_admin'

user 'web_admin' do
  group 'web_admin'
  system true
  shell '/bin/bash'
end
user 'db_admin' do
  group 'web_admin'
  system true
  shell '/bin/bash'
end

template '/var/www/html/index.html' do # ~FC033
  source 'index.html.erb'
  mode '0644'
  owner 'db_admin'
  group 'db_admin'
end
