test_machines = {
  'package_based' => { 
    'ip_address' => '172.30.0.140',
    'role' => 'redis_from_package'
  
  },
  'repo_based' => {
    'ip_address' => '172.30.0.141',
    'role' => 'redis_from_repo'
  } 
}
Vagrant.configure('2') do |config|
  config.vm.box = 'bento/ubuntu-16.04'
  test_machines.each do |machine, properties|
    config.vm.define machine do |box|
      
      box.vm.network :private_network, ip: properties["ip_address"]
      
      ####### Provision #######
      box.vm.provision 'chef_zero' do |chef|
        chef.cookbooks_path = "cookbooks"
        chef.nodes_path = 'nodes'
        chef.roles_path = "roles"
        chef.add_role properties['role']
      end
    end
  end
end

