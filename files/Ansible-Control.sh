#! /bin/bash
echo -e "\e[1;92m Setup for Ansible control node on Centos 8 Started \e[0m\n"

# Script Starts here
# echo -e "\e[1;92m TEXT \e[0m\n"
# Creating Group which will be used for Ansible Deployments
echo -e "\e[1;93m Setting up User pgrewal \e[0m\n"
groupadd devops
useradd -G devops -s /bin/bash -d /home/pgrewal -e -1 -c 'Devops User for Ansible' pgrewal
echo 'pgrewal:Google@1991' | chpasswd
echo 'root:Google@1991' | chpasswd
echo -e "\e[1;92m -----Completed----- \e[0m\n"

# Adding user to Sudoers file
echo -e "\e[1;93m Adding user pgrewal to sudoers \e[0m\n"
touch /home/pgrewal/devops
echo "%devops ALL=(ALL) NOPASSWD: ALL" > /home/pgrewal/devops
cp /home/pgrewal/devops /etc/sudoers.d/devops
echo -e "\e[1;92m ----Sudoers Added----- \e[0m\n"

# Adding Epel Repo to Centos 8 server
echo -e "\e[1;93m EPEL Repo adding to node \e[0m\n"
dnf install epel-release -y -q 
echo -e "\e[1;92m -----Completed----- \e[0m\n"

# Adding all Dev Tools which are helpfull during ansible playbooks writing
dnf group install "Development Tools" -y -q
echo -e "\e[1;93m Setting ansible control node with dev tools \e[0m\n"

# Adding tools which are needed for vim to behave as IDLE
dnf install gcc-c++ ncurses-devel ruby ruby-devel lua luajit luajit-devel ctags python3 python3-devel tcl-devel perl perl-devel perl-ExtUtils-ParseXS perl-ExtUtils-CBuilder perl-ExtUtils-Embed cscope gtk3-devel libSM-devel libXt-devel libXpm-devel libappstream-glib libacl-devel gpm-devel python2 python2-devel cmake git vim -y -q
echo -e "\e[1;92m -----Completed----- \e[0m\n"

# Installing Ansible Latest Version from EPEL
echo -e "\e[1;93m Installing Ansible \e[0m\n"
dnf install ansible -y -q
echo -e "\e[1;92m -----Completed----- \e[0m\n"

# Importent apps for any linux environment
echo -e "\e[1;93m Installing Screen & Tree Package \e[0m\n"
dnf install screen tree -y -q
echo -e "\e[1;92m -----Completed----- \e[0m\n"

# Updating Linux 
echo -e "\e[1;93m Updating System Packages \e[0m\n"
dnf update -y -q
echo -e "\e[1;92m -----Package Updated Successfully----- \e[0m\n"

# Setting up hostname of Ansible-Server
echo -e "\e[1;93m Setting hostname of server \e[0m\n"
hostnamectl set-hostname Ansible-Server
echo -e "\e[1;92m -----Set Hostname Successfully----- \e[0m\n"

# Confguring Static ip of Ansible-Server
echo -e "\e[1;93m Creating network config file for Static ip \e[0m\n"
touch /home/pgrewal/net-cfg
echo "#This is Ansible-Server Host-Only Adapter Config File for Static IP" >> /home/pgrewal/net-cfg
echo 'TYPE="Ethernet"' >> /home/pgrewal/net-cfg
echo 'BOOTPROTO="none"' >> /home/pgrewal/net-cfg
echo 'DEFROUTE="yes"' >> /home/pgrewal/net-cfg
echo 'NAME="enp0s8"' >> /home/pgrewal/net-cfg
echo 'DEVICE="enp0s8"' >> /home/pgrewal/net-cfg
echo 'ONBOOT="yes"' >> /home/pgrewal/net-cfg
echo 'IPADDR=192.168.56.101' >> /home/pgrewal/net-cfg
echo 'PREFIX=24' >> /home/pgrewal/net-cfg
echo 'GATEWAY=192.168.56.1' >> /home/pgrewal/net-cfg
echo 'DNS1=192.168.122.1' >> /home/pgrewal/net-cfg
cp /home/pgrewal/net-cfg /etc/sysconfig/network-scripts/ifcfg-enp0s8
echo -e "\e[1;92m ------ Static IP Configured----- \e[0m\n"

# Setting up Directory for Public so Ansible Server can access Managed node without password
echo -e "\e[1;93m Setting UP SSH Key \e[0m\n"
mkdir /home/pgrewal/.ssh
yes y | ssh-keygen -f /home/pgrewal/.ssh/id_rsa -q -t rsa -b 4096 -N '' >/dev/null

# Windows id_rsa for no password login
touch /home/pgrewal/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAivYs+i+1U1g5xIYpK3UL+q322eu3LEUUBYfW0rroO7v3Gl12Zi67f81FGAWaOpQTTM5N3Vam+AxlNMqJz+SdMLE3trVsfwRgz+Hx+cPvQM2kX3SbHzD4lbltYMUSSCJ3lZ9NTSoquyK4U2YV0vKg/14mQxnKq29Ju0RGAUaXH+40NR63sv+Zbm9XI+iphxI8gVMZsVnFk1PRru0ec8fDEg+jz/YzIyWlmas8GyhrH3tIfJFAWLLbon6VRiDnX6Cc0QU0CXOaLk6NNKzVKSRUSAyf3A5W/zRgYUBZ8HnUhiw/bq8wP4WzLFxbUKIhDFdxpYI9hNB1+95qnev6F3XAYw== rsa-key-20200710" >> /home/pgrewal/.ssh/authorized_keys
echo -e "\e[1;92m -----SSH configured for Ansible Node----- \e[0m\n"

chown pgrewal:devops /home/pgrewal/.ssh -R
chmod 600 /home/pgrewal/.ssh -R
echo -e "\e[1;92m SSH Key Created \e[0m\n"

# Restarting Network to reflect static IP
# nmcli connection down enp0s8 && nmcli connection up enp0s8

# Cleaning up Files
rm -rf /home/pgrewal/devops
echo -e "\e[1;92m -----devops file clean up done----- \e[0m\n"
rm -rf /home/pgrewal/net-cfg
echo -e "\e[1;92m -----net-cfg file clean up done----- \e[0m\n"

# Changing Permission of Ansible Directory
chown pgrewal:devops /etc/ansible -R
echo -e "\e[1;92m Permission set for ansible mount \e[0m\n"

# Setting Name Resolve for Ansible Managed Nodes
echo "192.168.56.201 Linux8-Node" >> /etc/resolv.conf
echo "192.168.56.202 Linux7-Node" >> /etc/resolv.conf
echo "192.168.56.203 Linux6-Node" >> /etc/resolv.conf
echo "192.168.56.204 Debian-Node" >> /etc/resolv.conf

# Setting Name Resolve for Ansible Managed Nodes
echo "192.168.56.201 Linux8-Node" >> /etc/hosts
echo "192.168.56.202 Linux7-Node" >> /etc/hosts
echo "192.168.56.203 Linux6-Node" >> /etc/hosts
echo "192.168.56.204 Debian-Node" >> /etc/hosts
echo -e "\e[1;92m -----Name Resolution for Managed hosts configured----- \e[0m\n"

# Changing motd banner
echo -e "\e[1;93m -----Changing Default Banner----- \e[0m\n"
echo "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+" > /etc/motd
echo "                     WELCOME TO  ANSIBLE CONTROL NODE                      " >> /etc/motd
echo "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+" >> /etc/motd
sed -i '/Banner/d' /etc/ssh/sshd_config
systemctl restart sshd
echo -e "\e[1;92m -----Banner Changed----- \e[0m\n"

echo -e "\e[1;93m -----Cloning Project Ansible----- \e[0m\n"
cd /home/pgrewal/
git clone https://github.com/punit144/Project-Ansible.git
echo -e "\e[1;92m -----Cloning Completed----- \e[0m\n"

# Rebooting Server
reboot




 

