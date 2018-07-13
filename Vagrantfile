# Plugins
# - https://github.com/oscar-stack/vagrant-hosts

# Setup Environment:
# - Create External Switch called "External Switch"
# - Get IP Address of the switch with (Get-NetIPConfiguration -InterfaceAlias 'vEthernet (External Switch)' | Get-NetIPAddress -AddressFamily IPv4 ).IPAddress
# - [Environment]::SetEnvironmentVariable("VAGRANT_DEFAULT_PROVIDER", "hyperv", "Machine")
# - [Environment]::SetEnvironmentVariable("VAGRANT_SMB_USERNAME", "", "Machine")
# - [Environment]::SetEnvironmentVariable("VAGRANT_SMB_PASSWORD", "", "Machine")
# - [Environment]::SetEnvironmentVariable("VAGRANT_HOST_IP", "", "Machine")

Vagrant.configure("2") do |config|
    # config.landrush.enabled = true
    # config.landrush.tld = "rancher"
  
    config.vm.define "master" do |master|
      # Set up a new box, use the same version as on PROD
      master.vm.box = "bento/ubuntu-16.04"
      master.vm.box_check_update = false
      master.vm.hostname = "rancher.local"

      # Connect guest to a switch
      master.vm.network "public_network", bridge: "External Switch"

      # Prevent vagrant from prompting for credentials
      config.vm.synced_folder '.', '/vagrant', {
        type: 'smb',
        mount_options: ['vers=3.0'],
        smb_username: ENV['VAGRANT_SMB_USERNAME'],
        smb_password: ENV['VAGRANT_SMB_PASSWORD']
      }

      # Rancher needs more than 1GB of memory
      master.vm.provider "hyperv" do |v|
        v.vmname = "rancher.local"
        v.linked_clone = true
        v.enable_virtualization_extensions = true
        v.memory = 4096
        v.cpus = 1
      end
  
      # Install docker and run rancher-server, it may take some time
      master.vm.provision "docker" do |d|
        d.run "r-server",
          image: "rancher/server:stable",
          args: "--restart=unless-stopped -p 8080:8080"
      end

      # Install common packages
      master.vm.provision "Common packages", type: "shell", path: "provision/packages-common.sh"

      # Install rancher-compose and rancher cli
      master.vm.provision "Rancher packages", type: "shell", path: "provision/packages-rancher.sh"

      # Install docker-compose
      master.vm.provision "Docker Compose packages", type: "shell", path: "provision/packages-docker-compose.sh"

      # Set environment variables 
      master.vm.provision "Host environment", type: "shell", path: "provision/host-environment.sh", env: {"HOST_IP" => ENV['VAGRANT_HOST_IP']}
  
      # Wait for Rancher to be availiable
      master.vm.provision "Rancher warm-up", type: "shell", path: "provision/rancher-wait.sh"
      
      # Setup environment variables used by rancher cli
      master.vm.provision "Rancher environment", type: "shell", path: "provision/rancher-environment.sh"

      # Provision rancher-agent on vm to register it as a rancher host
      master.vm.provision "Rancher add host", type: "shell", path: "provision/rancher-host.sh"

      # Provision global services
      master.vm.provision "Rancher global services", type: "shell", path: "provision/rancher-global.sh"
  
      # Provision two stacks for tests
      # master.vm.provision "shell", path: "provision/rancher-stacks.sh"
  
      # Provison nginx on master to route trafic to hosts in test mode
      # master.vm.provision "shell", path: "provision/nginx.sh"
  
      # Provision Tyk demo
      # master.vm.provision "shell", path: "provision/tyk-demo.sh"
    end
  
    # (1..2).each do |i|
    #   config.vm.define "host#{i}" do |host|
    #     # Set up a new box, use the same version as on PROD
    #     host.vm.box = "bento/ubuntu-16.04"
    #     host.vm.box_check_update = false
    #     host.vm.hostname = "host#{i}.rancher.local"
  
    #     # Rancher needs 1GB of memory
    #     host.vm.provider "virtualbox" do |v|
    #       v.name = "host#{i}"
    #       v.memory = 2048
    #       v.cpus = 1
    #     end
  
    #     # Set up an IP reachable from the host
    #     host.vm.network "private_network", ip: "192.168.0.10#{i}"
  
    #     # Provision docker engine
    #     host.vm.provision "docker"
  
    #     # Provision rancher-agent on vm to register vm as rancher host
    #     host.vm.provision "shell", path: "provision/rancher-host.sh"
    #   end
    # end
  
  end
  