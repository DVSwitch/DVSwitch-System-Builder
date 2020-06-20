#!/usr/bin/env bash
set -o errexit

# N4IRS 02/10/2020

#################################################
#                                               #
#    Build a DVSwitch Server on a clean disk    #
#                                               #
#################################################

# Install DVSwitch Repository
cd /tmp

# Add DVSwitch Repository and gpg key

if [ ! -f /etc/apt/sources.list.d/dvswitch.list ]
	then
	echo "deb http://dvswitch.org/ASL_Repository buster hamradio" >/etc/apt/sources.list.d/dvswitch.list
	wget -O - http://dvswitch.org/ASL_Repository/dvswitch.gpg.key | apt-key add -
fi

apt-get update

# print the installed repositories NEEDS work!
echo "Installed repositories:"
apt-cache policy | grep http | awk '{print $2 $3}' | sort -u

# Install needed programs
apt-get update -y
# apt-get install git -y
# apt-get install curl -y
# apt-get install libwxgtk3.0-dev -y
# apt-get install portaudio19-dev -y
# apt-get install libusb-1.0-0-dev -y
# apt-get install python-serial -y

apt-get install -y dvswitch-base

apt-get install -y analog-bridge
apt-get install -y md380-emu

apt-get install -y mmdvm-bridge
############### apt-get install -y dmrgateway

apt-get install -y nxdngateway
apt-get install -y nxdnparrot

apt-get install -y p25gateway
apt-get install -y p25parrot

apt-get install -y ysfgateway
apt-get install -y ysfparrot

apt-get install -y ircddbgateway

apt-get install -y quantar-bridge

# Don't run QB at boot for now.
systemctl disable quantar_bridge

exit 0

apt-get install lighttpd -y

# Need to add test for Buster vs Stretch vs Jessie
# apt-get install php7.0-common -y
# apt-get install php -y
apt-get install php7.3-cgi -y

chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html

lighty-enable-mod fastcgi
lighty-enable-mod fastcgi-php

FILE=/var/www/html/index.lighttpd.html
if test -f "$FILE"; then
    mv /var/www/html/index.lighttpd.html /var/www/html/index.lighttpd.html.old
fi

systemctl restart lighttpd

