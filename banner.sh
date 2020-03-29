#sed -i 's/INFO/INFO\nBanner /etc/banner-akun' /etc/ssh/sshd_config

#replace banner dropbear
sed -i 's/DROPBEAR_BANNER=""/DROPBEAR_BANNER="/etc/banner-akun"/g' /etc/default/dropbear

# bannerssh
wget "https://raw.githubusercontent.com/kumpulanremaja/vpssh/master/banner"
mv /banner /etc/banner-akun
chmod 0644 /etc/banner-akun
service dropbear restart
service ssh restart
