Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "public_network"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.synced_folder "zabbix/", "/etc/zabbix/zabbix_server.conf"
  config.vm.provider "virtualbox" do |vb|
    vb.name = "vagrant-zabbix-server"
  end
  config.vm.provision "shell", path:"zabbix.sh"
end
