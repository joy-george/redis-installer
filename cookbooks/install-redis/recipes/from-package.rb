#
# Cookbook:: install-redis
# Recipe:: from-repository
#
# Copyright:: 2019, The Authors, All Rights Reserved.

custom_install 'redis' do
  url node['redis']['source']['url']
  version node['redis']['git']['version']
  resource_directory node['redis']['resource_directory']
  action :install
  only_if { platform?('ubuntu') && !::Dir.exist?(node['redis']['resource_directory']) }
end
