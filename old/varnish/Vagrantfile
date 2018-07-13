# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"

  config.vm.network :private_network, ip: "10.0.0.10"
  config.vm.network :forwarded_port, guest: 6081, host: 8080
  
  config.vm.define :varnish do |varnish|
    $script_varnish = <<-SCRIPT
      curl -s https://packagecloud.io/install/repositories/varnishcache/varnish60/script.deb.sh | sudo bash
      sudo apt-get install -y varnish=6.0.0-1~xenial
    SCRIPT

    varnish.vm.provision :shell, :inline => $script_varnish
  end
end
