#
# Cookbook:: install-redis
# Spec:: from-repository
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'install-redis::from-repository' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:name) { 'redis' }
    let(:version) { '5.0.3' }
    let(:installation_type) { 'git' }
    let(:usr_local) { '/usr/local' }
    let(:install_directory) { "#{usr_local}/#{name}-#{version}" }
    let(:repository_url) { 'https://github.com/antirez/redis.git' }
    let(:revision) { "refs/tags/#{version}" }
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
    it 'installs redis from repository' do
      expect(chef_run).to sync_git("#{name}-#{version}")
        .with(repository: repository_url,
              revision: "refs/tags/#{version}",
              destination: install_directory)
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
