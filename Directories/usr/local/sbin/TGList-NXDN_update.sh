#! /bin/sh

###################################################
#                                                 #
# Download Subscriber IDs for NXDN                #
#                                                 #
###################################################

# TGList_NXDN.txt downloaded from http://www.pistar.uk/downloads/TGList_NXDN.txt
# sourced from https://raw.githubusercontent.com/g4klx/NXDNClients/master/NXDNGateway/NXDNHosts.txt
# Please report issues at https://www.facebook.com/groups/pistar/
# File created at Wednesday 23rd of May 2018 01:21:05 AM BST
#
# Dest ID;Name;Description
#
# TGListFile=TGList-NXDN.txt

wget -O /var/lib/mmdvm/TGList-NXDN.txt -q "http://www.pistar.uk/downloads/TGList_NXDN.txt"

