# -*- mode: ruby -*-
# vi: set ft=ruby :

# If using vagrant with cygwin on windows
ENV["VAGRANT_DETECTED_OS"] = ENV["VAGRANT_DETECTED_OS"].to_s + " cygwin"

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.

  # This is a nice box to use with puppet already on it.
  # config.vm.box = "puppetlabs/centos-7.0-64-puppet"

  # Or roll your own from a bare box with only the basics:
  config.vm.box = "centos-7"
  config.vm.box_url = "http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7.box"
  
  #I have a pile of vagrant boxes on a NAS drive to save network use.
  #config.vm.box_url = "P:/vagrant_boxes/CentOS-7.box"
  
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # Teamcity rolls on 8111
  config.vm.network "forwarded_port", guest: 8111, host: 18111

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "/vagrant_data"
 
  config.vm.provider "virtualbox" do |vb|
    #vb.gui = true
    vb.customize ["modifyvm", :id, "--cpus", "2", "--memory", "2048"]
  end

  config.vm.provider "vmware_fusion" do |v, override|
    v.vmx["numvcpus"] = "2"
    v.vmx["memsize"] = "2048"
  end

  # get us to a place to run puppet
  config.vm.provision "bootstrap", type: "shell" do |s|
    s.path = "provisioning/shell/bootstrap.sh"
  end

  # The environment thing is where puppet and vagrant fall down these days.
  config.vm.provision "init", type:"puppet" do |puppet|
    puppet.environment = "production"
    puppet.environment_path = "provisioning/puppet/environments"
    puppet.manifests_path = 'provisioning/puppet/environments/production/manifests'
    puppet.module_path = 'provisioning/puppet/environments/production/modules'
    puppet.manifest_file = 'init.pp'    
  end  
  
  config.vm.provision "teamcity", type: "shell" do |s|
    s.path = "provisioning/shell/teamcity.sh"
  end
  
end
