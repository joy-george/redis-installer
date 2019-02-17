#
# Cookbook:: install-redis
# Spec:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'install-redis::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    it 'it updates' do
      expect(chef_run).to run_execute('apt-get update')
    end
    it 'it installs build-essential' do
      expect(chef_run).to install_apt_package('build-essential')
    end
    it 'it installs tcl' do
      expect(chef_run).to install_apt_package('tcl')
    end
  end
end
