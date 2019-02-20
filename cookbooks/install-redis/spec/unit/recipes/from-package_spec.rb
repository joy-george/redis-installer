#
# Cookbook:: install-redis
# Spec:: from-repository
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'install-redis::from-package' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:name) { 'redis' }
    let(:version) { '5.0.3' }
    let(:download_directory) { Chef::Config['file_cache_path'] }
    let(:usr_local) { '/usr/local' }
    let(:install_directory) { "#{usr_local}/#{name}-#{version}" }
    let(:package_url) { "http://download.redis.io/releases/#{name}-#{version}.tar.gz" }
    let(:tar_package) { "#{name}-#{version}.tar.gz" }
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
    it 'downloads package from source' do
      expect(chef_run).to create_remote_file("#{download_directory}/#{tar_package}")
        .with(source: package_url)
    end
    it 'untar package' do
      expect(chef_run).to run_bash('uncompress')
        .with(cwd: download_directory,
              user: 'root',
              code: "tar -xvzf #{tar_package} -C #{usr_local}")
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
  end
end
