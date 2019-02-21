# # encoding: utf-8

# Inspec test for recipe install-redis::server

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe service('redis.service') do
  it { should be_installed }
  it { should be_running }
end

version = '5.0.3'
describe command('redis-server --version') do
  its('stdout') { should match /#{version}/ }
end

port = 6379
supervision_method = 'systemd'
pidfile = '/var/run/redis_6379.pid'
dir = '/var/lib/redis'
describe file('/etc/redis/redis.conf') do
  its('content') { should match /port\s#{port}/ }
  its('content') { should match /supervised\s#{supervision_method}/ }
  its('content') { should match /pidfile\s#{pidfile}/ }
  its('content') { should match /dir\s#{dir}/ }
end

describe port(port) do
  it { should be_listening }
end

only_if('redis cli is not installed.') do
  command('redis-cli').exist?
end

test_inspec = (0...6).map { (65 + rand(26)).chr }.join
describe command("redis-cli SET test_inspec '#{test_inspec}'") do
  its('stdout') { should match /OK/ }
end

describe command('redis-cli GET test_inspec') do
  its('stdout') { should match /#{test_inspec}/ }
end
