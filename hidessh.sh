#!/bin/bash

# install package
apt-get update;
apt-get upgrade;
apt-get -y install wget curl;

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# Tambah Port
cd
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i 's/Port 22/Port  22/g' /etc/ssh/sshd_config
service ssh restart

# Install Dropbear
cd
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=44/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 77 "/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
service ssh restart
service dropbear restart

#intall ngix
cd
apt-get install nginx

# install squid3
cd
apt-get -y install squid3
rm /etc/squid/squid.conf
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/kholizsivoi/script/master/squid3.conf"
sed -i  /etc/squid/squid.conf;
service squid restart

#install stunnel
cd
apt-get -y stunnel4
