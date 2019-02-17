#
# Cookbook:: install-redis
# Recipe:: from-repository
#
# Copyright:: 2019, The Authors, All Rights Reserved.

custom_install 'redis' do
  url node['redis']['git']['url']
  version node['redis']['git']['version']
  installation_type 'git'
  branch node['redis']['git']['branch']
  resource_directory node['redis']['resource_directory']
  action :install
  not_if { !platform_family?('ubuntu') && File.exist?(node['redis']['resource_directory']) }
end
