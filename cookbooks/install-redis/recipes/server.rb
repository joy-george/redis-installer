#
# Cookbook:: install-redis
# Recipe:: server
#
# Copyright:: 2019, The Authors, All Rights Reserved.

template "#{node['redis']['etc_conf_dir']}/redis.conf" do
  source 'redis.conf.erb'
  variables partials: {
    'fqdn' => node[:fqdn],
    'supervision_method' => node['redis']['supervision_method'],
    'port' => node['redis']['port'],
    'pidfile' => node['redis']['pidfile'],
    'db_directory' => node['redis']['db_directory'],
  }
end

template '/etc/systemd/system/redis.service' do
  source 'redis.service.erb'
  variables partials: {
    'fqdn' => node['fqdn'],
    'user' => node['redis']['user'],
    'group' => node['redis']['group'],
    'conf_file' => "#{node['redis']['etc_conf_dir']}/redis.conf",
  }
end

service 'redis.service' do
  action :start
end
