#!/bin/bash
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%50s%s%-20s\n' "BadVPN Setup 0.9 por Phreaker56 y Traducido por Ph502" ; tput sgr0
if [ -f "/usr/local/bin/badvpn-udpgw" ]
then
	tput setaf 3 ; tput bold ; echo ""
	echo ""
	echo "El BadVPN ya ha sido instalado con éxito."
	echo "Para ejecutar, crear una sesión screen"
	echo "Y ejecute el comando:"
	echo ""
	echo "badudp"
	echo ""
	echo "Y deje la sesión screen ejecutando en segundo plano"
	echo "" ; tput sgr0
	exit
else
tput setaf 2 ; tput bold ; echo ""
echo "Este es un script que compila e instala automáticamente el programa"
echo "BadVPN en los servidores de Debian y Ubuntu para habilitar el enrutamiento UDP"
echo "en el puerto 7300, utilizado por programas como HTTP Inyector de Evozi."
echo "Permitiendo así el uso del protocolo UDP para juegos en línea,"
echo "llamadas VoIP y otras cosas interesantes."
echo "" ; tput sgr0
read -p "Desea continuar? [s/n]: " -e -i n respuesta
if [[ "$respuesta" = 's' ]]; then
	echo ""
	echo "La instalación puede tardar bastante ... sea paciente!"
	sleep 3
	apt-get update -y
	apt-get install screen wget gcc build-essential g++ make -y
	wget http://www.cmake.org/files/v2.8/cmake-2.8.12.tar.gz
	tar xvzf cmake*.tar.gz
	cd cmake*
	./bootstrap --prefix=/usr
	make 
	make install
	cd ..
	rm -r cmake*
	mkdir badvpn-build
	cd badvpn-build
	wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/badvpn/badvpn-1.999.128.tar.bz2
	tar xf badvpn-1.999.128.tar.bz2
	cd bad*
	cmake -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
	make install
	cd ..
	rm -r bad*
	cd ..
	rm -r badvpn-build
	echo "#!/bin/bash
	badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 512 --max-connections-for-client 8" > /bin/badudp
	chmod +x /bin/badudp
	clear
	tput setaf 3 ; tput bold ; echo ""
	echo ""
	echo "BadVPN fue instalado con Éxito."
	echo "Para usar, cree una sesión screen"
	echo "Y ejecute el comando:"
	echo ""
	echo "badudp"
	echo ""
	echo "Y deje la sesión screen ejecutando en segundo plano."
	echo "" ; tput sgr0
	exit
else 
	echo ""
	exit
fi
fi
