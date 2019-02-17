#
# Cookbook:: install-redis
# Spec:: from-repository
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'install-redis::from-repository' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:installation_type) { 'git' }
    let(:download_directory) { '/tmp/redis_git_2/redis-5.0.3' }
    let(:repository) { 'https://github.com/antirez/redis.git' }
    let(:revision) { '5.0' }
    let(:redis_directory) { '/usr/local/share/redis' }
    let(:chef_run) do
      runner = ChefSpec::ServerRunner
               .new(step_into: 'custom_install',
                    platform: 'ubuntu',
                    version: '16.04')
      runner.converge(described_recipe)
    end
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    it 'installs redis from repository' do
      expect(chef_run).to custom_install('redis')
        .with(installation_type: installation_type)
    end
    it 'creates download directory' do
      expect(chef_run).to create_directory(download_directory)
        .with(owner: 'root',
              mode: '0644',
              recursive: true)
    end

    it 'build package' do
      expect(chef_run).to run_bash('make')
        .with(cwd: download_directory,
              user: 'root',
              code: 'make')
    end

    it 'install package' do
      expect(chef_run).to run_bash('make_install')
        .with(cwd: download_directory,
              user: 'root',
              code: 'make install')
    end

    it 'creates a link with redis directory' do
      expect(chef_run).to create_link(redis_directory)
        .with(to: download_directory)
    end
  end
end
