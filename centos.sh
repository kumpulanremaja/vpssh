#!/bin/bash
# Script Auto Installer by HideSSH
# Creator : Galih Putra
# initialisasi var
OS=`uname -p`;

# go to root
cd


# update software server
yum update -y

# go to root
cd

# setting repo centos 7 64bit
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

# setting rpmforge
wget https://ftp.tu-chemnitz.de/pub/linux/dag/redhat/el7/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
rpm -Uvh rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service sshd restart

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.d/rc.local

# install wget and curl
yum -y install wget curl

# remove unused
yum -y remove sendmail;
yum -y remove httpd;
yum -y remove cyrus-sasl

# update
yum -y update

# install webserver
yum -y install nginx php-fpm php-cli
service nginx restart
service php-fpm restart
chkconfig nginx on
chkconfig php-fpm on

# install essential package
yum -y install rrdtool screen iftop htop nmap bc nethogs vnstat ngrep mtr git zsh mrtg unrar rsyslog rkhunter mrtg net-snmp net-snmp-utils expect nano bind-utils
yum -y groupinstall 'Development Tools'
yum -y install cmake
yum -y --enablerepo=rpmforge install axel sslh ptunnel unrar

# matiin exim
service exim stop
chkconfig exim off

# setting vnstat
vnstat -u -i eth0
echo "MAILTO=root" > /etc/cron.d/vnstat
echo "*/5 * * * * root /usr/sbin/vnstat.cron" >> /etc/cron.d/vnstat
service vnstat restart
chkconfig vnstat on

# install screenfetch
cd
wget https://gitlab.com/kumpulanremaja/configssh/-/raw/master/config/screenfetch-dev
mv screenfetch-dev /usr/bin/screenfetch
chmod +x /usr/bin/screenfetch
echo "clear" >> .bash_profile
echo "screenfetch" >> .bash_profile

# install badvpn
cd
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/khairilg/script-jualan-ssh-vpn/master/conf/badvpn-udpgw"
if [ "$OS" == "x86_64" ]; then
  wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/khairilg/script-jualan-ssh-vpn/master/conf/badvpn-udpgw64"
fi
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.d/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300

# setting port ssh
cd
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i 's/#Port 22/Port  22/g' /etc/ssh/sshd_config
service sshd restart
chkconfig sshd on

# install dropbear
yum -y install dropbear
echo "OPTIONS=\"-p 44 -p 77 \"" > /etc/sysconfig/dropbear
echo "/bin/false" >> /etc/shells
service dropbear restart
chkconfig dropbear on

# install fail2ban
cd
yum -y install fail2ban
service fail2ban restart
chkconfig fail2ban on

# install squid
yum -y install squid
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/khairilg/script-jualan-ssh-vpn/master/conf/squid-centos.conf"
sed -i $MYIP2 /etc/squid/squid.conf;
service squid restart
chkconfig squid on


# auto kill multi login
#echo "while :" >> /usr/bin/autokill
#echo "  do" >> /usr/bin/autokill
#echo "  userlimit $llimit" >> /usr/bin/autokill
#echo "  sleep 20" >> /usr/bin/autokill
#echo "  done" >> /usr/bin/autokill

# downlaod script
cd /usr/bin
wget -O speedtest "https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py"
wget -O bench "https://raw.githubusercontent.com/khairilg/script-jualan-ssh-vpn/master/bench-network.sh"
wget -O mem "https://raw.githubusercontent.com/pixelb/ps_mem/master/ps_mem.py"
wget -O userlogin "https://raw.githubusercontent.com/khairilg/script-jualan-ssh-vpn/master/user-login.sh"
wget -O userexpire "https://raw.githubusercontent.com/khairilg/script-jualan-ssh-vpn/master/autoexpire.sh"
wget -O usernew "https://raw.githubusercontent.com/khairilg/script-jualan-ssh-vpn/master/create-user.sh"
wget -O userdelete "https://raw.githubusercontent.com/khairilg/script-jualan-ssh-vpn/master/user-delete.sh"
wget -O userlimit "https://github.com/khairilg/script-jualan-ssh-vpn/raw/master/user-limit.sh"
wget -O renew "https://raw.githubusercontent.com/khairilg/script-jualan-ssh-vpn/master/user-renew.sh"
wget -O userlist "https://raw.githubusercontent.com/khairilg/script-jualan-ssh-vpn/master/user-list.sh" 
wget -O trial "https://raw.githubusercontent.com/khairilg/script-jualan-ssh-vpn/master/user-trial.sh"
echo "cat /root/log-install.txt" | tee info
echo "speedtest --share" | tee speedtest
wget -O /root/chkrootkit.tar.gz ftp://ftp.pangeia.com.br/pub/seg/pac/chkrootkit.tar.gz
tar zxf /root/chkrootkit.tar.gz -C /root/
rm -f /root/chkrootkit.tar.gz
mv /root/chk* /root/chkrootkit
wget -O checkvirus "https://github.com/khairilg/script-jualan-ssh-vpn/raw/master/checkvirus.sh"
#wget -O cron-autokill "https://raw.githubusercontent.com/khairilg/script-jualan-ssh-vpn/master/cron-autokill.sh"
wget -O cron-dropcheck "https://github.com/khairilg/script-jualan-ssh-vpn/raw/master/cron-dropcheck.sh"

# sett permission
chmod +x userlogin
chmod +x userdelete
chmod +x userexpire
chmod +x usernew
chmod +x userlist
chmod +x userlimit
chmod +x renew
chmod +x trial
chmod +x info
chmod +x speedtest
chmod +x bench
chmod +x mem
chmod +x checkvirus
#chmod +x autokill
#chmod +x cron-autokill
chmod +x cron-dropcheck

# cron
cd
service crond start
chkconfig crond on
service crond stop
echo "0 */12 * * * root /bin/sh /usr/bin/userexpire" > /etc/cron.d/user-expire
echo "0 */12 * * * root /bin/sh /usr/bin/reboot" > /etc/cron.d/reboot
#echo "* * * * * root /bin/sh /usr/bin/cron-autokill" > /etc/cron.d/autokill
echo "* * * * * root /bin/sh /usr/bin/cron-dropcheck" > /etc/cron.d/dropcheck
#echo "0 */1 * * * root killall /bin/sh" > /etc/cron.d/killak

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# finalisasi
service nginx start
service php-fpm start
service vnstat restart
service openvpn restart
service snmpd restart
service sshd restart
service dropbear restart
service fail2ban restart
service squid restart
service crond start
chkconfig crond on

# info
echo "Layanan yang diaktifkan"  | tee -a log-install.txt
echo "--------------------------------------"  | tee -a log-install.txt
echo "Port OpenSSH : 22, 143"  | tee -a log-install.txt
echo "Port Dropbear : 44 ,77 "  | tee -a log-install.txt
echo "SquidProxy    : 8080, 8888, 3128 (limit to IP SSH)"  | tee -a log-install.txt
echo "Nginx : 81"  | tee -a log-install.txt
echo "badvpn   : badvpn-udpgw port 7300"  | tee -a log-install.txt
echo "Timezone : Asia/Jakarta"  | tee -a log-install.txt
echo "Fail2Ban : [on]"  | tee -a log-install.txt
echo "IPv6     : [off]"  | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "--------------"  | tee -a log-install.txt
echo "speedtest --share : untuk cek speed vps"  | tee -a log-install.txt
echo "mem : untuk melihat pemakaian ram"  | tee -a log-install.txt
echo "checkvirus : untuk scan virus / malware"  | tee -a log-install.txt
echo "bench : untuk melihat performa vps" | tee -a log-install.txt
echo "usernew : untuk membuat akun baru"  | tee -a log-install.txt
echo "userlist : untuk melihat daftar akun beserta masa aktifnya"  | tee -a log-install.txt
echo "userlimit <limit> : untuk kill akun yang login lebih dari <limit>. Cth: userlimit 1"  | tee -a log-install.txt
echo "userlogin  : untuk melihat user yang sedang login"  | tee -a log-install.txt
echo "userdelete  : untuk menghapus user"  | tee -a log-install.txt
echo "trial : untuk membuat akun trial selama 1 hari"  | tee -a log-install.txt
echo "renew : untuk memperpanjang masa aktif akun"  | tee -a log-install.txt
echo "info : untuk melihat ulang informasi ini"  | tee -a log-install.txt
echo "--------------"  | tee -a log-install.txt

#hapus auto script
rm -f /root/centos.sh
