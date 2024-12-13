IMAGE_NAME = "bento/debian-12"

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |v|
        v.memory = 2048 # RAM 2 GB
        v.cpus = 2      # 2 CPU
    end

    config.vm.define "debian" do |debian|
        debian.vm.box = IMAGE_NAME
        debian.vm.network "forwarded_port", guest: 22, host: 2206, host_ip: "127.0.0.1"
        debian.vm.hostname = "debian"
    end

    config.vm.provision "file", source: "id_rsa.pub", destination: "/home/vagrant/.ssh/me.pub"
    config.vm.provision "shell", inline: <<-SHELL
        cat /home/vagrant/.ssh/me.pub >> /home/vagrant/.ssh/authorized_keys
    SHELL

    config.vm.provision "shell", path: "provision.sh"
end