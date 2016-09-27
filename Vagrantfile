# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.7.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  %w(centos-6.6 debian-7.7 ubuntu-12.04 ubuntu-14.04).each do |os|
    config.vm.define os do |node|
      config.vm.hostname = "instance-linux"
      config.omnibus.chef_version = 'latest' if
        Vagrant.has_plugin?('vagrant-omnibus')
      config.berkshelf.enabled = true if
        Vagrant.has_plugin?('vagrant-berkshelf')
      config.vm.box = "chef/#{os}"
      config.vm.network :private_network, ip: '192.168.10.100'
      config.vm.provision :chef_solo do |chef|
        chef.json = {
          :"ganeti" => {
            :"master-node" => true,
            :"cluster" => {
              :"master-netdev" => 'lo',
              :"extra-opts" => '--vg-name ganeti -H kvm:kernel_path=""',
              :"disk-templates" => %w(plain),
              :"nic" => {
                :"mode" => 'routed',
                :"link" => '100'
              },
              :"name" => 'ganeti.local'
            }
          }
        }
        chef.run_list = %w(
          recipe[apt]
          recipe[instance-linux-devel]
          recipe[ganeti]
          recipe[instance-linux-devel::install]
          recipe[instance-linux-devel::variants]
        )
      end
    end
  end
end
