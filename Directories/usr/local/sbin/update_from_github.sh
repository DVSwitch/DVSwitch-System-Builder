#!/usr/bin/env bash
set -o errexit

# N4IRS 01/17/2020

#################################################
#                                               #
# Get latest binaries from GtHub                #
#                                               #
#################################################

# Start here
arch=$(dpkg --print-architecture)
echo system architecture is $arch

wget -O /usr/local/sbin/AMBEtest4.py https://github.com/DVSwitch/Analog_Bridge/raw/master/scripts/AMBEtest4.py
chmod +x /usr/local/sbin/AMBEtest4.py

wget -O /opt/MMDVM_Bridge/MMDVM_Bridge https://github.com/DVSwitch/MMDVM_Bridge/raw/master/bin/MMDVM_Bridge.$arch
chmod +x /opt/MMDVM_Bridge/MMDVM_Bridge

wget -O /opt/Analog_Bridge/Analog_Bridge https://github.com/DVSwitch/Analog_Bridge/raw/master/bin/Analog_Bridge.$arch
chmod +x /opt/Analog_Bridge/Analog_Bridge



