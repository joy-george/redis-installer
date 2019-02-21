default['redis']['git']['version'] = '5.0.3'
default['redis']['git']['url'] = 'https://github.com/antirez/redis.git'
default['redis']['source']['url'] = "http://download.redis.io/releases/redis-#{default['redis']['git']['version']}.tar.gz"

default['usr_local'] = '/usr/local'
default['redis']['resource_directory'] = "#{default['usr_local']}/redis-#{default['redis']['git']['version']}"
default['redis']['etc_conf_dir'] = '/etc/redis'
default['redis']['port'] = '6379'
default['redis']['supervision_method'] = 'systemd'
default['redis']['pidfile'] = "/var/run/redis_#{default['redis']['port']}.pid"
default['redis']['db_directory'] = '/var/lib/redis'
default['redis']['uid'] = 1001
default['redis']['user'] = 'redis'
default['redis']['gid'] = 2001
default['redis']['group'] = 'redis'
