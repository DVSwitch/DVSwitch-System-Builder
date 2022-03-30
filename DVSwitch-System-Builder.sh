#!/usr/bin/env bash
set -o errexit

# N4IRS 11/02/2020

#################################################
#                                               #
#    Build a DVSwitch Server on a clean disk    #
#                                               #
#################################################

# Install DVSwitch Repository
cd /tmp

wget http://dvswitch.org/buster
chmod +x buster
./buster

apt-get update --allow-releaseinfo-change
apt-get install dvswitch-server -y

# cd /srv/Repositories/N0MJS
# git clone https://github.com/HBLink-org/dmr_utils.git
# git clone https://github.com/HBLink-org/HBLink.git
# git clone https://github.com/HBLink-org/DMRlink.git
# git clone -b HB_Bridge https://github.com/HBLink-org/HBLink.git HB_Bridge
# git clone -b IPSC_Bridge https://github.com/HBLink-org/DMRlink.git IPSC_Bridge

