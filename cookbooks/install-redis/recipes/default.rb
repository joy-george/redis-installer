#
# Cookbook:: install-redis
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

execute 'apt-get update' do
  command 'apt-get update'
end
apt_package 'build-essential' do
  package_name 'build-essential'
  action :install
end
apt_package 'tcl' do
  package_name 'tcl'
  action :install
end

group node['redis']['group'] do
  gid node['redis']['gid']
  action :create
  system true
end

user node['redis']['user'] do
  comment 'Redis user'
  uid node['redis']['uid']
  gid node['redis']['gid']
  system true
end

directory node['redis']['db_directory'] do
  group node['redis']['group']
  owner node['redis']['user']
  mode '770'
  recursive true
  action :create
end

directory node['redis']['etc_conf_dir'] do
  group 'root'
  owner 'root'
  recursive true
  action :create
end
