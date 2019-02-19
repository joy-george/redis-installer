#
# Cookbook:: install-redis
# Spec:: server
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'install-redis::server' do
  let(:redis_gid) { 2001 }
  let(:redis_uid) { 1001 }

  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates redis.conf' do
      expect(chef_run).to create_template('/etc/redis/redis.conf').with(
        source:  'redis.conf.erb'
      )
    end

    it 'creates /etc/systemd/system/redis.service' do
      expect(chef_run).to create_template('/etc/systemd/system/redis.service').with(
        source:  'redis.service.erb'
      )
    end

    it 'starts redis service with an explicit action' do
      expect(chef_run).to start_service('redis.service')
    end
  end
end
