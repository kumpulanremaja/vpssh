#!/bin/bash
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;

flag=0

echo


if [ $USER != 'root' ]; then
	echo "Sorry, for run the script please using root user"
	exit
fi
echo "
AUTOSCRIPT BY Jucky vengeance

PLEASE CANCEL ALL PACKAGE POPUP

TAKE NOTE !!!"
clear
echo "START AUTOSCRIPT"
clear
echo "SET TIMEZONE JAKARTA GMT +7"
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime;
clear
echo "
Remove spam
COMPLETE 10%
"
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove postfix*;
apt-get -y --purge remove bind*;
apt-get -y --purge remove dropbear*;


echo "
UPDATE AND UPGRADE PROCESS 

PLEASE WAIT TAKE TIME 1-5 MINUTE
"
# install essential package
apt-get -y install build-essential
apt-get -y install cron bmon iftop htop nmap axel nano iptables traceroute sysv-rc-conf dnsutils bc nethogs openvpn vnstat less screen psmisc apt-file whois ptunnel ngrep mtr git zsh mrtg snmp snmpd snmp-mibs-downloader unzip tar zip rsyslog debsums rkhunter

apt-get update;apt-get -y upgrade;apt-get -y install wget curl
echo "
INSTALLER PROCESS PLEASE WAIT
TAKE TIME 5-10 MINUTE
"
# login setting
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells

#text gambar
apt-get install boxes

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local


# install badvpn
wget -O /usr/bin/badvpn-udpgw "http://kimnoon.configinter.net/ssh/script/badvpn-udpgw"wget -O /usr/bin/badvpn-udpgw "http://kimnoon.configinter.net/ssh/script/badvpn-udpgw"
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300

# squid3
apt-get update
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/squid.conf"
sed -i "s/ipserver/$myip/g" /etc/squid3/squid.conf
chmod 0640 /etc/squid3/squid.conf

# text warna
cd
rm -rf .bashrc
wget -O .bashrc https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/text-20warna/.bashrc

# text pelangi
sudo apt-get install ruby -y
sudo gem install lolcat

# nginx
apt-get -y install nginx php5-fpm php5-cli
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>Setup by jucky vengeance WA 083898587500</pre>" > /home/vps/public_html/index.php
echo "<?php phpinfo(); ?>" > /home/vps/public_html/info.php
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/vps.conf"
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf

# install openvpn
apt-get install openvpn -y
wget -O /etc/openvpn/openvpn.tar "https://raw.github.com/danangtrihermansyah/premium/master/conf/openvpn-debian.tar"
cd /etc/openvpn/
tar xf openvpn.tar
wget -O /etc/openvpn/1194.conf "https://raw.github.com/danangtrihermansyah/premium/master/conf/1194.conf"
service openvpn restart
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
wget -O /etc/iptables.conf "https://raw.github.com/danangtrihermansyah/premium/master/conf/iptables.conf"
sed -i '$ i\iptables-restore < /etc/iptables.conf' /etc/rc.local

myip2="s/ipserver/$myip/g";
sed -i $myip2 /etc/iptables.conf;

iptables-restore < /etc/iptables.conf
service openvpn restart

# configure openvpn client config
cd /etc/openvpn/
wget -O /etc/openvpn/1194-client.ovpn "https://raw.github.com/danangtrihermansyah/premium/master/conf/1194-client.conf"
usermod -s /bin/false mail
echo "mail:deenie" | chpasswd
useradd -s /bin/false -M deenie11
echo "deenie11:deenie" | chpasswd
#tar cf client.tar 1194-client.ovpn
cp /etc/openvpn/1194-client.ovpn /home/vps/public_html/
sed -i $myip2 /home/vps/public_html/1194-client.ovpn
sed -i "s/ports/55/" /home/vps/public_html/1194-client.ovpn

# setting port ssh
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i 's/Port 22/Port  22/g' /etc/ssh/sshd_config
#sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0:80/g' /etc/ssh/sshd_config
service ssh restart

# install dropbear
#apt-get install dropbear
#apt-get install zlib1g-dev
#wget "https://raw.githubusercontent.com/danangtrihermansyah/premium/master/dropbear201674/dropbear-2016.74.tar.bz2"
#bzip2 -cd dropbear-2016.74.tar.bz2 | tar xvf -
#cd dropbear-2016.74
#./configure
#make && make install
#mv /usr/sbin/dropbear /usr/sbin/dropbear1
#ln /usr/local/sbin/dropbear /usr/sbin/dropbear
#service dropbear restart
apt-get install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=3128/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 80 -p 777"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
service ssh restart
service dropbear restart

# bannerssh
wget -O bannersshlink.sh "https://raw.githubusercontent.com/danangtrihermansyah/premium/master/menu/bannersshlink.sh"
chmod 700 bannersshlink.sh
./bannersshlink.sh
rm bannersshlink.sh

# install fail2ban
apt-get -y install fail2ban;service fail2ban restart
# install webmin 1.820_all.deb
cd
wget "http://prdownloads.sourceforge.net/webadmin/webmin_1.680_all.deb"
dpkg --install webmin_1.680_all.deb
apt-get -y -f install
rm /root/webmin_1.680_all.deb
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
service webmin restart

# auto reboot 24jam
cd
echo "0 0 * * * root /usr/bin/reboot" > /etc/cron.d/reboot
echo "0 12 * * * root /usr/bin/reboot" > /etc/cron.d/reboot
echo "0 2 * * * root echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a" > /etc/cron.d/clearcacheram3swap
echo "0 1 * * * root service dropbear restart" > /etc/cron.d/dropbear
echo "0 1 * * * root service ssh restart" >> /etc/cron.d/dropbear
echo "0 6 * * * root service dropbear restart" > /etc/cron.d/dropbear1
echo "0 6 * * * root service ssh restart" >> /etc/cron.d/dropbear1
#echo "0 9 * * * root service dropbear restart" > /etc/cron.d/dropbear2
#echo "0 9 * * * root service ssh restart" >> /etc/cron.d/dropbear2
echo "0 12 * * * root service dropbear restart" > /etc/cron.d/dropbear3
echo "0 12 * * * root service ssh restart" >> /etc/cron.d/dropbear3
echo "0 15 * * * root service dropbear restart" > /etc/cron.d/dropbear4
echo "0 15 * * * root service ssh restart" >> /etc/cron.d/dropbear4
#echo "0 20 * * * root service dropbear restart" > /etc/cron.d/dropbear5
#echo "0 20 * * * root service ssh restart" >> /etc/cron.d/dropbear5
echo "0 23 * * * root service dropbear restart" > /etc/cron.d/dropbear6
echo "0 23 * * * root service ssh restart" >> /etc/cron.d/dropbear6
#echo "* * * * * root sleep 10; ./userlimit.sh 2" > /etc/cron.d/userlimit2
#echo "* * * * * root sleep 20; ./userlimit.sh 2" > /etc/cron.d/userlimit4
#echo "* * * * * root sleep 30; ./userlimit.sh 2" > /etc/cron.d/userlimit6
#echo "* * * * * root sleep 40; ./userlimit.sh 2" > /etc/cron.d/userlimit8
#echo "* * * * * root sleep 50; ./userlimit.sh 2" > /etc/cron.d/userlimit11
echo "0 1 * * * root ./userexpired.sh" > /etc/cron.d/userexpired
echo "0 * * * * root ./clearcache.sh" > /etc/cron.d/clearcache1
echo "10 * * * * root ./clearcache.sh" > /etc/cron.d/clearcache2
echo "20 * * * * root ./clearcache.sh" > /etc/cron.d/clearcache3
echo "30 * * * * root ./clearcache.sh" > /etc/cron.d/clearcache4
echo "40 * * * * root ./clearcache.sh" > /etc/cron.d/clearcache5
echo "50 * * * * root ./clearcache.sh" > /etc/cron.d/clearcache6

# auto kill dropbear
#wget "https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/userlimit.sh"
#mv ./userlimit /usr/bin/userlimit.sh
#chmod +x /usr/bin/userlimit.sh
#echo " /etc/security/limits.conf" > /etc/security/limits.conf

# auto kill openssh
#wget "https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/userlimitssh.sh"
#mv ./userlimitssh.sh /usr/bin/userlimitssh.sh
#chmod +x /usr/bin/userlimitssh.sh

# cranjob
#sudo apt-get install cron
#wget "https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/crontab"
#mv crontab /etc/
#chmod 644 /etc/crontab

# tool 
cd
wget -O userlimit.sh "https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/userlimit.sh"
wget -O userexpired.sh "https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/userexpired.sh"
#wget -O autokill.sh "https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/autokill.sh"
wget -O userlimitssh.sh "https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/userlimitssh.sh"
echo "@reboot root /root/userexpired.sh" >> /etc/cron.d/userexpired
#echo "@reboot root /root/userlimit.sh" > /etc/cron.d/userlimit
#echo "@reboot root /root/userlimitssh.sh" > /etc/cron.d/userlimitssh
#echo "@reboot root /root/autokill.sh" > /etc/cron.d/autokill
#sed -i '$ i\screen -AmdS check /root/autokill.sh' /etc/rc.local
chmod +x userexpired.sh
chmod 755 userlimit.sh
#chmod +x autokill.sh
chmod +x userlimitssh.sh

# clear cache
service cron stop
wget -O clearcache.sh "https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/clearcache.sh"
mv ./clearcache.sh /root/clearcache.sh
#echo "@reboot root /root/clearcache.sh" > /etc/cron.d/clearcache
chmod 755 /root/clearcache.sh

# clear cache squid
wget -O clearcachesquid.sh "https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/clearcachesquid.sh"
mv ./clearcachesquid.sh /root/clearcachesquid.sh
chmod ug+x /root/clearcachesquid.sh
service cron start
# userlimit
#cd
#wget "https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/limit.conf"
#mv limits.conf /etc/security/limits.conf
#chmod 644 /etc/security/limits.conf

# buka port 80
iptables -I INPUT -p tcp --dport 80 -j ACCEPT


# speedtest
cd
apt-get install python
wget -O speedtest.py "https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/speedtest.py"
chmod +x speedtest.py

# Install Menu
cd
wget "https://raw.githubusercontent.com/bestsshme/ssl.sh/master/menu"
mv ./menu /usr/local/bin/menu
chmod +x /usr/local/bin/menu

# install bannermenu
wget -O bannermenu "https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/logoatas"
mv ./bannermenu /root/bannermenu
chmod +x /root/bannermenu

# aktifkan SSL/tls
wget "https://raw.githubusercontent.com/bestsshme/ssl.sh/master/ssl.sh"
chmod +x ssl.sh



# delete user expire
wget -O delete-user-expire.sh "http://centos6.esy.es/file/delete-user-expire"
chmod +x delete-user-expire.sh
chmod +x ./delete-user-expire.sh


# update script vps
cd
wget -O /usr/local/bin/menu-update-script-vps.sh "https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/menu-update-script-vps.sh"
mv ./menu-update-script-vps.sh /usr/local/bin/menu-update-script-vps.sh
chmod +x /usr/local/bin/menu-update-script-vps.sh

# pendukung shc
cd
apt-get install yum
yum -y install make automake autoconf gcc gcc++
apt-get -y install build-essential
aptitude -y install build-essential
#shc file
cd
wget "https://raw.githubusercontent.com/danangtrihermansyah/premium/master/shc-3.8.7.tgz"
tar xvfz shc-3.8.7.tgz
#cd shc-3.8.7
#make
clear
echo "=========================================================="
echo "-------------------Tanggal Kadaluarsa MENU----------------"
echo "##########################################################"
echo -e "Wajib di isi bos " 

echo -e "Contoh Format Tanggal: 30/07/2018 (2 digit/2 digit/4 digit)"
echo -e "Angka semua ya boss!"
echo ""
read -p "Silahkan Ketikan Tanggal Kadaluarsa (menu): " deeniemenu
cd shc-3.8.7
make
./shc -e $deeniemenu -m "Maaf boss MENU ente sudah kadaluarsa silahkan hubungi admin jucky vengeance" -f /usr/local/bin/menu
clear
#./shc -e $deeniemenu -f /usr/local/bin/menu
#./shc -f /usr/local/bin/menu
cd
mv /usr/local/bin/menu.x /usr/local/bin/menu
chmod +x /usr/local/bin/menu
cd
rm /usr/local/bin/menu.x.c

# hapus installan shc
rm -rf /root/shc-3.8.7
rm /root/shc-3.8.7.tgz

# swap ram
dd if=/dev/zero of=/swapfile bs=1024 count=1024k
# buat swap
mkswap /swapfile
# jalan swapfile
swapon /swapfile
#auto star saat reboot
wget "https://raw.githubusercontent.com/juckyvengeanceee/debian.sh/master/fstab"
mv ./fstab /etc/fstab
chmod 644 /etc/fstab
sysctl vm.swappiness=10
#permission swapfile
chown root:root /swapfile 
chmod 0600 /swapfile

cd
# disable exim
service exim4 stop
sysv-rc-conf exim4 off
cd
rm -rf /etc/cron.weekly/
rm -rf /etc/cron.hourly/
rm -rf /etc/cron.monthly/
rm -rf /etc/cron.daily/
echo "UPDATE AND INSTALL COMPLETE COMPLETE 99% BE PATIENT"
rm $0;rm *.txt;rm *.tar;rm *.deb;rm *.asc
clear
service cron restart
service openvpn restart
service squid3 restart
service ssh restart
service webmin restart
service dropbear restart
service nginx start
rm debian7x64.sh
rm ./debian7x64.sh

#clear
echo "========================================"  
echo "Service Autoscript VPS " 
echo "----------------------------------------" 
echo "" 
echo "Webmin   : http://$myip:10000/"
echo "Squid3   : 8080" 
echo "OpenSSH  : 22," 
echo "Dropbear : 80, 777"
echo "SSL/TLS  : 443"
echo "OpenVPN  : TCP Port 55 (client config : http://$myip:81/1194-client.ovpn)" 
echo "Timezone : Asia/Jakarta"
echo "Fail2Ban : [on]"
echo ""
echo "----------------------------------------"
echo "        SCRIPT BY JUCKY VENGEANCE       "
echo "             WA: 083898587500           "
echo "        FB: fb.com/Juckyvengeance       "
echo "----------------------------------------"
echo " INSTALLASI SELESAI...!!!"
echo "----------------------------------------"
echo "========================================"  
echo ""
echo ""
echo "      SILAHKAN REBOOT VPS ANDA !" 
echo "========================================"
cat /dev/null > ~/.bash_history && history -c
