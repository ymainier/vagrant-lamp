Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. For a detailed explanation
  # and listing of configuration options, please view the documentation
  # online.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "lucid32"

  config.chef.cookbooks_path = "cookbooks"
  config.vm.provisioner = :chef_solo

  config.vm.forward_port("http", 80, 8080)

  config.chef.json.merge!({
    :mysql => {
      :server_root_password => "root"
    }
  })
  
end
