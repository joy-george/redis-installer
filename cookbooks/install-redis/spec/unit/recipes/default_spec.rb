#
# Cookbook:: install-redis
# Spec:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'install-redis::default' do
  let(:redis_gid) { 2001 }
  let(:redis_uid) { 1001 }
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    it 'updates packages' do
      expect(chef_run).to run_execute('apt-get update')
    end
    it 'installs build-essential' do
      expect(chef_run).to install_apt_package('build-essential')
    end
    it 'installs tcl' do
      expect(chef_run).to install_apt_package('tcl')
    end
    it 'creates groups successfully' do
      expect(chef_run).to create_group('redis').with(gid: redis_gid)
    end
    it 'creates users successfully' do
      expect(chef_run).to create_user('redis').with(uid: redis_uid, gid: redis_gid)
    end
    it 'creates redis db directory' do
      expect(chef_run).to create_directory('/var/lib/redis')
        .with(owner: 'redis',
              group: 'redis',
              mode: '770',
              recursive: true)
    end
    it 'creates redis resource directory' do
      expect(chef_run).to create_directory('/etc/redis')
        .with(owner: 'root',
              group: 'root',
              recursive: true)
    end
  end
end
