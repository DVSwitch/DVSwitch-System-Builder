#!/usr/bin/env bash
set -o errexit

# N4IRS 06/19/2018

#################################################
#                                               #
#    Build a MMDVM Node on a clean disk         #
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
apt-get install git-core -y
apt-get install curl -y
apt-get install g++ -y
apt-get install make -y
apt-get install dvswitch -y
apt-get install quantar -y

# For Armbian Need to check this !
# apt-get install libstdc++-arm-none-eabi-newlib -y

# Need to save the working directory. This will work for now
cd /srv/DVSwitch-System-Builder

cp -rf ./Directories/* /


# Clone the source code for the programs we want to install
# The directories were installed from above

cd /srv/Repositories/N4IRS
git clone https://github.com/N4IRS/MMDVMHost-Dashboard.git

## cd /srv/Repositories/DVSwitch

cd /srv/Repositories/G4KLX
git clone https://github.com/g4klx/DMRGateway.git
git clone https://github.com/g4klx/P25Clients.git
git clone https://github.com/g4klx/YSFClients.git
git clone https://github.com/g4klx/NXDNClients.git

cd /srv/Repositories/N0MJS
git clone https://github.com/n0mjs710/dmr_utils.git
git clone https://github.com/n0mjs710/HBlink.git
git clone https://github.com/n0mjs710/DMRlink.git
git clone -b HB_Bridge https://github.com/n0mjs710/HBlink.git HB_Bridge
git clone -b IPSC_Bridge https://github.com/n0mjs710/DMRlink.git IPSC_Bridge

# cd /srv/Repositories/OpenDV
# Nothing here

# Copy the source directories to /usr/src
# This allows me to keep a pristine copy in /srv/Repositories

cd /srv/Repositories/N4IRS
cp -R MMDVMHost-Dashboard/* /var/www/html/

# cd /srv/Repositories/DVSwitch
# Nothing here

cd /srv/Repositories/G4KLX
cp -rf DMRGateway /usr/src

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

# Populate the datafiles
#
/etc/cron.daily/DMRIDUpdateBM
/etc/cron.daily/FCSRoomsupdate
/etc/cron.daily/HBIDUpdate
/etc/cron.daily/NXDNHostsupdate
/etc/cron.daily/NXDNIDUpdate
/etc/cron.daily/P25Hostsupdate
/etc/cron.daily/TGList-DMR_update
/etc/cron.daily/TGList-NXDN_update
/etc/cron.daily/TGList-P25_update
/etc/cron.daily/XLXHostsupdate
/etc/cron.daily/YSFHostsupdate

# Install the dashboard
#
apt-get install lighttpd -y

# Need to add test for Stretch vs Jessie
# apt-get install php7.0-common -y
# apt-get install php -y
apt-get install php7.0-cgi -y

chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html

lighty-enable-mod fastcgi
lighty-enable-mod fastcgi-php

mv /var/www/html/index.lighttpd.html /var/www/html/index.lighttpd.html.old

systemctl restart lighttpd

# Add DVSwitch programs via apt-get install
