if defined?(ChefSpec)
  def custom_install(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:custom_install, :install, resource_name)
  end
end
