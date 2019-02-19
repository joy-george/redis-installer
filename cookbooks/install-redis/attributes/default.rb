default['redis']['git']['version'] = '5.0.3'
default['redis']['git']['url'] = 'https://github.com/antirez/redis.git'

default['redis']['git']['branch'] = '5.0'
default['redis']['source']['url'] = 'http://download.redis.io/releases/redis-5.0.3.tar.gz'

default['custom_install']['download_directory'] = '/custom_downloads'
default['redis']['resource_directory'] = '/etc/redis'

default['redis']['port'] = '6379'
default['redis']['supervision_method'] = 'systemd'

default['redis']['pidfile'] = "/var/run/redis_#{default['redis']['port']}.pid"
default['redis']['db_directory'] = '/var/lib/redis'

default['redis']['gid'] = 2001
default['redis']['uid'] = 1001

default['redis']['user'] = 'redis'
default['redis']['group'] = 'redis'
