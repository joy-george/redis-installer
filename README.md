# Redis Installer

It sets up **Ubuntu-16.04** Virtual Boxes and installs **Redis-5.0.3** from package(tar.gz) and/or from it's repository using Vagrant. The installation and configuration is done using Chef cookbook-**install-redis** and hence it can be used on any (currently only `ubuntu 16.04`) Chef Client hosts

## Requirements
Tested with below components on OSX-10.14.3
- [VirtualBox 6.0](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant 2.2.3](https://www.vagrantup.com/downloads.html)
- [Chef Development Kit Version: 3.7.23](https://downloads.chef.io/chefdk/) - For running integration tests.

## Installation
Once the requirements are installed, open up a terminal. We'll need to clone this repository and setup vagrant:

##### Clone Repository
```SH
git clone https://github.com/joy-george/redis-installer.git
cd redis-installer
```

##### Check Vagrant is functional
```SH
redis-installer$ vagrant up --no-provision
```

##### Creating Node directory
This will help vagrant to store all the node information
```SH
redis-installer$ mkdir nodes
```

## Provisioning
```SH
redis-installer$ vagrant provision
```

The current vagrant setup will create 2 virtual boxes
- **172.30.0.140:** With Redis server installed from package
- **172.30.0.141:** With Redis server installed from repository

If required, the above configuration can be modified from the [Vagrantfile](https://github.com/joy-george/redis-installer/blob/master/Vagrantfile "Vagrantfile")

## Testing
Integration test can be done after provision to verify
-   Redis has been installed
-   Redis is running
-   Redis is runing on version 5.0.3
-   Configuration changes are in place and correct
-   Service listens to necessary ports (6379)
-  Redis is able to set and get test key values

#### Executing the test
##### Testing **172.30.0.140:**
```SH
redis-installer$ chef exec inspec exec cookbooks/install-redis/test/integration/default/server_test.rb -t ssh://vagrant@172.30.0.140 --password=vagrant
```
![From  Package](https://raw.githubusercontent.com/joy-george/redis-installer/master/redis_from_package.png)

##### Testing **172.30.0.141:**
```SH
redis-installer$ chef exec inspec exec cookbooks/install-redis/test/integration/default/server_test.rb -t ssh://vagrant@172.30.0.141 --password=vagrant
```
![From  Repository](https://raw.githubusercontent.com/joy-george/redis-installer/master/redis_from_repo.png)