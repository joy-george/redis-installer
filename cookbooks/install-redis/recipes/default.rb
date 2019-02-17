#
# Cookbook:: install-redis
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

if platform_family?('ubuntu')
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
end
