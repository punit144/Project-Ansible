#! /bin/bash
echo -e "\e[1;93m Startiong to Configure Ansible Managed Node Linux8-Node \e[0m\n"

# Script Starts here
# echo -e "\e[1;92m TEXT \e[0m\n\n"
# Creating Group which will be used for Ansible Deployments
echo -e "\e[1;93m Setting up User pgrewal \e[0m\n"
groupadd devops
useradd -G devops -s /bin/bash -d /home/pgrewal -e -1 -c 'User for Ansible' pgrewal
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
echo -e "\e[1;93m Installing Git \e[0m\n"
# Adding Git Package
dnf install git -y -q
echo -e "\e[1;92m -----Completed----- \e[0m\n"

# Importent apps for any linux environment
echo -e "\e[1;93m Installing Screen & Tree Package \e[0m\n"
dnf install screen tree -y -q
echo -e "\e[1;92m -----Completed----- \e[0m\n"
# Updating Linux 
echo -e "\e[1;93m Updating System Packages \e[0m\n"
dnf update -y -q
echo -e "\e[1;92m -----Package Updated Successfully----- \e[0m\n"

# Setting up hostname of Server
echo -e "\e[1;93m Setting hostname of server \e[0m\n"
hostnamectl set-hostname Linux8-Node
echo -e "\e[1;92m -----Set Hostname Successfully----- \e[0m\n"

# Confguring Static ip of Server
echo -e "\e[1;93m Creating network config file for Static ip \e[0m\n"
touch /home/pgrewal/net-cfg
echo "#This is Ansible-Server Host-Only Adapter Config File for Static IP" >> /home/pgrewal/net-cfg
echo 'TYPE="Ethernet"' >> /home/pgrewal/net-cfg
echo 'BOOTPROTO="none"' >> /home/pgrewal/net-cfg
echo 'DEFROUTE="yes"' >> /home/pgrewal/net-cfg
echo 'NAME="enp0s8"' >> /home/pgrewal/net-cfg
echo 'DEVICE="enp0s8"' >> /home/pgrewal/net-cfg
echo 'ONBOOT="yes"' >> /home/pgrewal/net-cfg
echo 'IPADDR=192.168.56.201' >> /home/pgrewal/net-cfg
echo 'PREFIX=24' >> /home/pgrewal/net-cfg
echo 'GATEWAY=192.168.56.1' >> /home/pgrewal/net-cfg
echo 'DNS1=192.168.56.1' >> /home/pgrewal/net-cfg
cp /home/pgrewal/net-cfg /etc/sysconfig/network-scripts/ifcfg-enp0s8
echo -e "\e[1;92m ------ Static IP Configured----- \e[0m\n"

# Setting up Directory for Public so Ansible Server can access Managed node without password
echo -e "\e[1;93m Setting UP SSH Key \e[0m\n"
mkdir /home/pgrewal/.ssh
yes y | ssh-keygen -f /home/pgrewal/.ssh/id_rsa -q -t rsa -b 4096 -N '' >/dev/null
echo -e "\e[1;92m SSH Key Created \e[0m\n"

# Setting up id_rsa for no password login from Control Ansible Node
touch /home/pgrewal/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCc6aj5obpnrv9pCuxX0jHCzN49ZoUOCNlzZB7x9nQJTTlr0BX01D7GRJZcO0pr8M8FDmIxvLxmem1b0jU0nShsYxBwKItupDGoct0ABWlX8/FcXDoov8oKEiunLDg6q51IDvXw8HSgwutSueIdi45v+q2oAtKATgntlwryfVsL5VPa74GiLNY3bNz8IAyMQG0bz6CBFgxoXhITdxgW0SIlVy5Zq9Z4nIMIDSNjAE+iz6yJGSm1lblM876mMn/GpIWPXW2BG4s0HIdEvENv9NQG5eaW2WFpYJcu7m8/REgs/TvAdejBbE2ANA/Luek1fvtUZ4HGda374oqrl5arPAJcesQIziq9nZtjoXHd+78EoBHwbV+O70e2AUvu6hV0lWeuPcr4t0Uu0lAVlI65y+meuFxxt0XzL4mcx9vQvriOGN2xx4pjk1jJmSEJRpyCWH2pEksa0J0KqX3clPXJLzdzNoJ4ynSz/kPTvcohnZEs+u5xnMbyoUqBXIzl/buFEc6qTeyPWMYFpJ4pEbklikBmCZ2J0K3ZdHFA3C+KnL4OWA53joYLOUepRePZSBPzb3/8vMO5RNS+8jXxGk5ra+FX8HWUOBAQMq94PthMqLysdiN/KmgDNykHDHjn4i2azsq8KMR2inX7NDo+lt2HOQiFr1rkfmrmKCgqjbxvqsiBBQ== root@Ansible-Server" >> /home/pgrewal/.ssh/authorized_keys
echo -e "\e[1;92m -----SSH configured for Managed Node----- \e[0m\n"
chown pgrewal:devops /home/pgrewal/.ssh -R
chmod 700 /home/pgrewal/.ssh -R
chmod 600 /home/pgrewal/.ssh/authorized_keys
# Restarting Network to reflect static IP
# nmcli connection down enp0s8 && nmcli connection up enp0s8

# Cleaning up Files
rm -rf /home/pgrewal/devops
echo -e "\e[1;92m -----devops file clean up done----- \e[0m\n"
rm -rf /home/pgrewal/net-cfg
echo -e "\e[1;92m -----net-cfg file clean up done----- \e[0m\n"

# Setting Name Resolve for Ansible Managed Nodes
echo "192.168.56.201 Linux8-Node" >> /etc/resolv.conf

# Setting Name Resolve for Ansible Managed Nodes
echo "192.168.56.201 Linux8-Node" >> /etc/hosts
echo -e "\e[1;92m -----Name Resolution for Managed hosts configured----- \e[0m\n"

# Changing motd banner
echo -e "\e[1;93m -----Changing Default Banner----- \e[0m\n"
echo "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+" > /etc/motd
echo "+                WELCOME TO  ANSIBLE MANAGED NODE LINUX8-NODE             +" >> /etc/motd
echo "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+" >> /etc/motd
sed -i '/Banner/d' /etc/ssh/sshd_config
systemctl restart sshd
echo -e "\e[1;92m -----Banner Changed----- \e[0m\n"

# Rebooting Server
reboot
