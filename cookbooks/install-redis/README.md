# install_redis

It installs **Redis-5.0.3** from package or from its repository. The installation method is handled by the Custom Resource **custom_install**

## Recipes

*  `default` - Updates apt packages, installs and sets up base requirements

*  `install_from_package` - Install from [redis package](http://download.redis.io/releases/redis-5.0.3.tar.gz)

*  `install_from_repo` - Installs from the [Git Revision refs/tags/5.0.3](https://github.com/antirez/redis/tree/5.0.3)

*  `server` - Configures and starts the redis server
  
## Integration
Supports platforms: ubuntu 16.04

Cookbook dependencies:
* tcl
* build-essential

## Attributes

- **node['redis']['git']['version']** - Currently tested with redis version 5.0.3
- **node['redis']['git']['url']** - Redis Git clone URL - 'https://github.com/antirez/redis.git'
- **node['redis']['source']['url']** - Redis Package URL - 'http://download.redis.io/releases/redis-5.0.3.tar.gz'
- **node['usr_local']** - where redis will be installed under the resource directory  - `/usr/local/`
- **node['redis']['resource_directory']** - Redis installation path - `/usr/local/redis-5.0.3`
- **node['redis']['etc_conf_dir']** -  File path where the redis configuration file wll be placed - `/etc/redis/`
- **node['redis']['port']** -  Port on which Redis will be listening on `6379`
- **node['redis']['supervision_method']** - Supervision method set to `systemd` to enable Redis to run as a 
- **node['redis']['pidfile']** -  File path to store Redis's `pid` file
- **node['redis']['db_directory']** -  File path to store Redis's `DB` file
- **node['redis']['uid']** - Redis user ID - `1001`
- **node['redis']['user']** - Redis user name - `redis`
- **node['redis']['gid']** - Group ID for redis - `2001`
- **node['redis']['group']** - Group name for redis - `redis`

## Resources
- **custom_install**

### Actions
-   `:install`: installs a resource (redis) either from given package or git

###### Examples
The below example downloads `redis-5.0.3` from package url 
 ```RB
 custom_install "redis" do
	url 'http://download.redis.io/releases/redis-5.0.3.tar.gz'
	version '5.0.3'
	resource_directory '/usr/local/redis-5.0.3'
	action :install
 end
```

The below example downloads `redis-5.0.3` from git repository
 ```RB
 custom_install "redis" do
	url 'https://github.com/antirez/redis.git'
	version '5.0.3'
	rep_revision "refs/tags/5.0.3"
	resource_directory '/usr/local/redis-5.0.3'
	installation_type 'git'
	action :install
 end
```

## Next Steps
- Move resource and cookbook out to individual repositories
- Add recipes to clean up installed resources
- Add support to uncompress packages with other extensions as well apart from `tar.gz`
- Integrate with Travis CI