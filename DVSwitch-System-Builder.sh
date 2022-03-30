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
