#!/bin/bash
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# install essential package
apt-get -y install build-essential
apt-get -y install cron bmon iftop htop nmap axel nano iptables traceroute sysv-rc-conf dnsutils bc nethogs
apt-get -y install vnstat less screen psmisc apt-file whois ptunnel ngrep mtr git zsh mrtg snmp snmpd snmp-mibs-downloader unzip tar zip rsyslog debsums rkhunter

apt-get update;
apt-get -y upgrade;
apt-get -y install wget curl

# login setting
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells

# setting port ssh
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i 's/Port 22/Port  22/g' /etc/ssh/sshd_config
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart

# install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=44/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 77"/g' /etc/default/dropbear
service ssh restart
service dropbear restart


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

# Install Menu
cd
wget "https://raw.githubusercontent.com/bestsshme/ssl.sh/master/menu"
mv ./menu /usr/local/bin/menu
chmod +x /usr/local/bin/menu


# delete user expire
wget -O delete-user-expire.sh "http://centos6.esy.es/file/delete-user-expire"
chmod +x delete-user-expire.sh
chmod +x ./delete-user-expire.sh



clear
service cron restart
service openvpn restart
service squid3 restart
service ssh restart
service webmin restart
service dropbear restart
service nginx start
