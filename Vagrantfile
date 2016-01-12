# -*- mode: ruby -*-
# vi: set ft=ruby

Vagrant.configure("2") do |config|

  # Config
  numNodes = 3

  (numNodes).downto(1).each do |i|
    config.vm.define "slave#{i}" do |node|
      node.vm.box = "precise64"
      node.vm.box_url = "http://files.vagrantup.com/precise64.box"

      node.vm.provider :virtualbox do |vb|
        vb.name = "slave#{i}.vm-cluster.com"
        vb.customize ["modifyvm", :id, "--memory", "2048", "--cpus", "1"]
      end

      node.vm.provider :vmware_fusion do |vm, override|
        override.vm.box = "precise64_fusion"
        vm.vmx["memsize"] = "2048"
        vm.vmx["numvcpus"] = "1"
      end

      node.vm.network :private_network, ip: "10.211.55.10#{i}"
      node.vm.hostname = "slave#{i}.vm-cluster.com"

      node.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

      node.vm.provision :puppet do |puppet|
        puppet.manifests_path = "puppet/manifests"
        puppet.manifest_file = "site.pp"
        puppet.module_path = "puppet/modules"
      end
      node.vm.provision :shell, path: "bootstrap.sh"
      node.vm.provision :shell do |sh|
        sh.path = "install/setup-hosts.sh"
        sh.args = "-t #{numNodes}"
      end
      node.vm.provision :shell do |sh|
        sh.path = "install/setup-hadoop-slaves.sh"
        sh.args = "-s 1 -t #{numNodes}"
      end
      node.vm.provision :shell do |sh|
        sh.path = "install/setup-spark-slaves.sh"
        sh.args = "-s 1 -t #{numNodes}"
      end
    end
  end

  config.vm.define :master do |master|
    master.vm.box = "precise64"
    master.vm.box_url = "http://files.vagrantup.com/precise64.box"

    master.vm.provider :virtualbox do |vb|
      vb.name = "vm-cluster-master"
      vb.customize ["modifyvm", :id, "--memory", "4096", "--cpus", "2"]
    end

    master.vm.provider :vmware_fusion do |vm, override|
      override.vm.box = "precise64_fusion"
      vm.vmx["memsize"] = "4096"
      vm.vmx["numvcpus"] = "2"
    end

    master.vm.network :private_network, ip: "10.211.55.100"
    master.vm.hostname = "master.vm-cluster.com"

    master.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    master.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file = "site.pp"
      puppet.module_path = "puppet/modules"
    end
    master.vm.provision :shell, path: "bootstrap.sh"
    master.vm.provision :shell do |sh|
      sh.path = "install/setup-hosts.sh"
      sh.args = "-t #{numNodes}"
    end
    master.vm.provision :shell do |sh|
      sh.path = "install/setup-hadoop-slaves.sh"
      sh.args = "-s 1 -t #{numNodes}"
    end
    master.vm.provision :shell do |sh|
      sh.path = "install/setup-spark-slaves.sh"
      sh.args = "-s 1 -t #{numNodes}"
    end
    master.vm.provision :shell, path:"install/init-services.sh"
  end
end