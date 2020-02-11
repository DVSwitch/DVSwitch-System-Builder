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

wget http://dvswitch.org/install-dvswitch-repo
chmod +x install-dvswitch-repo
./install-dvswitch-repo

# Install needed programs
# This could be pruned
#
apt-get update -y
apt-get install git -y
apt-get install curl -y
apt-get install g++ -y
apt-get install make -y
apt-get install jq -y
apt-get install build-essential -y
apt-get install libwxgtk3.0-dev -y
apt-get install portaudio19-dev -y
apt-get install libusb-1.0-0-dev -y
apt-get install chkconfig -y
apt-get install python-serial -y
apt-get install dvswitch -y
apt-get install quantar -y

# For Armbian Need to check this !
# apt-get install libstdc++-arm-none-eabi-newlib -y

# Need to save the working directory. This will work for now

cd /srv/DVSwitch-System-Builder

cp -rf ./Directories/* /

# Update the data files for gateways
# /usr/local/sbin/DVSM_Update.sh

# Clone the source code for the programs we want to install
# The directories were installed from above

cd /srv/Repositories/DVSwitch
git clone https://github.com/DVSwitch/MMDVMHost-Dashboard.git

## cd /srv/Repositories/DVSwitch

cd /srv/Repositories/G4KLX
git clone https://github.com/g4klx/DMRGateway.git
git clone https://github.com/g4klx/P25Clients.git
git clone https://github.com/g4klx/YSFClients.git
git clone https://github.com/g4klx/NXDNClients.git
git clone https://github.com/g4klx/ircDDBGateway.git

cd /srv/Repositories/N0MJS
git clone https://github.com/n0mjs710/dmr_utils.git
git clone https://github.com/n0mjs710/HBlink.git
git clone https://github.com/n0mjs710/DMRlink.git
git clone -b HB_Bridge https://github.com/n0mjs710/HBlink.git HB_Bridge
git clone -b IPSC_Bridge https://github.com/n0mjs710/DMRlink.git IPSC_Bridge

# Copy the source directories to /usr/src
# This allows me to keep a pristine copy in /srv/Repositories

cd /srv/Repositories/DVSwitch
cp -R MMDVMHost-Dashboard/* /var/www/html/

cd /srv/Repositories/G4KLX
cp -rf DMRGateway /usr/src

cp -rf ircDDBGateway /usr/src/

cd /srv/Repositories/G4KLX/NXDNClients
cp -rf NXDNGateway NXDNParrot /usr/src

cd /srv/Repositories/G4KLX/P25Clients
cp -rf P25Gateway P25Parrot /usr/src

cd /srv/Repositories/G4KLX/YSFClients
cp -rf YSFGateway YSFParrot /usr/src



# cd /srv/Repositories/N0MJS
# Flesh this out

## Build the programs from source
## Yes, this is brute force

cd /usr/src/DMRGateway
make clean
make
cp DMRGateway /opt/DMRGateway
cp -rf Audio /opt/DMRGateway

cd /usr/src/ircDDBGateway
make clean
make
make install

cd /usr/src/NXDNGateway
make clean
make
cp NXDNGateway /opt/NXDNGateway
cp -rf Audio /opt/NXDNGateway

cd /usr/src/NXDNParrot
make clean
make
cp NXDNParrot /opt/NXDNParrot

cd /usr/src/P25Gateway
make clean
make
cp P25Gateway /opt/P25Gateway

cd /usr/src/P25Parrot
make clean
make
cp P25Parrot /opt/P25Parrot

cd /usr/src/YSFGateway
make clean
make
cp YSFGateway /opt/YSFGateway

cd /usr/src/YSFParrot
make clean
make
cp YSFParrot /opt/YSFParrot

/usr/local/sbin/DVSM_Update.sh

# Enable the systemd unit files
#
systemctl enable systemd-networkd-wait-online.service
systemctl enable nxdngateway.service
systemctl enable nxdnparrot.service
systemctl enable p25gateway.service
systemctl enable p25parrot.service
systemctl enable ysfgateway.service
systemctl enable ysfparrot.service
systemctl enable netcheck.service
systemctl enable ircddbgatewayd.service

# Populate the datafiles
#
# /etc/cron.daily/DMRIDUpdateBM
# /etc/cron.daily/FCSRoomsupdate
# /etc/cron.daily/HBIDUpdate
# /etc/cron.daily/NXDNHostsupdate
# /etc/cron.daily/NXDNIDUpdate
# /etc/cron.daily/P25Hostsupdate
# /etc/cron.daily/TGList-DMR_update
# /etc/cron.daily/TGList-NXDN_update
# /etc/cron.daily/TGList-P25_update
# /etc/cron.daily/XLXHostsupdate
# /etc/cron.daily/YSFHostsupdate

# Install the dashboard
#

# Clean out unneeded database update scripts
/usr/local/sbin/cleanup.sh

apt-get install lighttpd -y

# Need to add test for Stretch vs Jessie
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

# Add DVSwitch programs via apt-get install
