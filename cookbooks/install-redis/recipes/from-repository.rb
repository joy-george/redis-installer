#
# Cookbook:: install-redis
# Recipe:: from-repository
#
# Copyright:: 2019, The Authors, All Rights Reserved.

custom_install 'redis' do
  url node['redis']['git']['url']
  version node['redis']['git']['version']
  rep_revision "refs/tags/#{node['redis']['git']['version']}"
  resource_directory node['redis']['resource_directory']
  installation_type 'git'
  action :install
  only_if { platform?('ubuntu') && !::Dir.exist?(node['redis']['resource_directory']) }
end
