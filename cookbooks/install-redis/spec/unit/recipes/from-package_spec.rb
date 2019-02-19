#
# Cookbook:: install-redis
# Spec:: from-repository
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'install-redis::from-package' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:download_directory) { '/custom_downloads' }
    let(:install_directory) { "#{download_directory}/redis-5.0.3" }
    let(:package_url) { 'http://download.redis.io/releases/redis-5.0.3.tar.gz' }
    let(:version) { '5.0.3' }
    let(:redis_directory) { '/etc/redis' }
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

    it 'creates download directory' do
      expect(chef_run).to create_directory(download_directory)
        .with(owner: 'root',
              mode: '0644',
              recursive: true)
    end

    it 'downloads package from source' do
      expect(chef_run).to create_remote_file("#{download_directory}/redis-#{version}.tar.gz")
        .with(source: package_url)
    end

    it 'untar package' do
      expect(chef_run).to run_bash('uncompress')
        .with(cwd: download_directory,
              user: 'root',
              code: "tar -xvzf #{download_directory}/redis-#{version}.tar.gz")
    end

    it 'build package' do
      expect(chef_run).to run_bash('make')
        .with(cwd: install_directory,
              user: 'root',
              code: 'make')
    end

    it 'install package' do
      expect(chef_run).to run_bash('make_install')
        .with(cwd: install_directory,
              user: 'root',
              code: 'make install')
    end

    it 'creates a link with redis directory' do
      expect(chef_run).to create_link(redis_directory)
        .with(to: install_directory)
    end
  end
end
