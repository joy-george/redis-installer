# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :custom_install
provides :custom_install
default_action :nothing

property :custom_resource_name, String, name_property: true
property :url, String
property :version, String
property :rep_revision, String
property :installation_type, String
property :download_directory, String
property :resource_directory, String
property :usr_local, String
property :tar_package, String

action :install do
  new_resource.download_directory = Chef::Config['file_cache_path']
  new_resource.usr_local = node['usr_local']
  new_resource.tar_package = "#{new_resource.custom_resource_name}-#{new_resource.version}.tar.gz"
  case new_resource.installation_type
  when 'git'
    git "#{new_resource.name}-#{new_resource.version}" do
      repository new_resource.url
      revision new_resource.rep_revision
      destination new_resource.resource_directory
      action :sync
    end
  else
    remote_file "#{new_resource.download_directory}/#{new_resource.tar_package}" do
      source new_resource.url
      action :create
    end
    bash 'uncompress' do
      user 'root'
      cwd new_resource.download_directory
      code "tar -xvzf #{new_resource.tar_package} -C #{new_resource.usr_local}"
    end
  end
  bash 'make' do
    user 'root'
    cwd new_resource.resource_directory
    code 'make'
  end
  bash 'make_install' do
    user 'root'
    cwd new_resource.resource_directory
    code 'make install'
  end
end
