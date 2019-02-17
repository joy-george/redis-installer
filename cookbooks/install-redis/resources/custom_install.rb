# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :custom_install
provides :custom_install
default_action :nothing

property :custom_resource_name, String, name_property: true
property :url, String
property :version, String
property :branch, String
property :installation_type, String
property :resource_directory, String

action :install do
  @download_directory = "#{node['custom_install']['download_directory']}/#{new_resource.custom_resource_name}/#{new_resource.version}"
  action_create_directory
  action_link_resource_directory

  case new_resource.installation_type
  when 'git'
    action_download_from_version_control
  else
    action_download_from_package
  end
  action_build_package
  action_install_package
end
action :create_directory do
  directory @download_directory do
    owner 'root'
    mode '0644'
    recursive true
    action :create
  end
end

action :download_from_version_control do
  git @download_directory do
    repository new_resource.url
    revision new_resource.branch
    action :sync
  end
end

action :build_package do
  working_dir = @download_directory
  bash 'make' do
    user 'root'
    cwd working_dir
    code 'make'
  end
end

action :install_package do
  working_dir = @download_directory
  bash 'make_install' do
    user 'root'
    cwd working_dir
    code 'make install'
  end
end

action :link_resource_directory do
  working_dir = @download_directory
  link new_resource.resource_directory do
    to working_dir
    action :create
  end
end
