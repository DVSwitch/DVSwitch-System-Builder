#!/usr/bin/env bash
set -o errexit

# N4IRS 01/17/2020

#################################################
#                                               #
# Remove old DB update scripts and soft links   #
#                                               #
#################################################

# Start here

rm /usr/local/sbin/DMRIDUpdateBM.sh
rm /usr/local/sbin/DMRIDUpdate.sh
rm /usr/local/sbin/HBIDUpdate.sh
rm /usr/local/sbin/NXDNIDUpdate.sh
rm /usr/local/sbin/TGListUpdate.sh
rm /usr/local/sbin/XLXHostsupdate.sh
rm /usr/local/sbin/YSFHostsupdate.sh

rm /etc/cron.daily/DMRIDUpdateBM
rm /etc/cron.daily/HBIDUpdate
rm /etc/cron.daily/NXDNIDUpdate
rm /etc/cron.daily/TGListUpdate
rm /etc/cron.daily/XLXHostsupdate
rm /etc/cron.daily/YSFHostsupdate
