Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "public_network"
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.provider "virtualbox" do |vb|
    vb.name = "vagrant-zabbix-server"
  end
  config.vm.provision "shell", path:"zabbix.sh"
end
