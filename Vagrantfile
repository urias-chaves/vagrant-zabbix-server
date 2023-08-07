Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "public_network"
  config.vm.network "forwarded_port", guest: 10051, host: 80
  config.vm.provider "virtualbox" do |vb|
    vb.name = "vagrant-zabbix-server"
  end
  config.vm.provision "shell", path:"zabbix.sh"
end
