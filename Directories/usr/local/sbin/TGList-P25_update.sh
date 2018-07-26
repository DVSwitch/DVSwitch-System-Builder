#! /bin/sh

###################################################
#                                                 #
# Download Subscriber IDs for P25                 #
#                                                 #
###################################################
# TGList_P25.txt downloaded from http://www.pistar.uk/downloads/TGList_P25.txt
# sourced from https://raw.githubusercontent.com/g4klx/P25Clients/master/P25Gateway/P25Hosts.txt
# Please report issues at https://www.facebook.com/groups/pistar/
# File created at Wednesday 23rd of May 2018 01:21:05 AM BST
#
# Dest ID;Name;Description
#

# TGListFile=TGList-P25.txt

wget -O /var/lib/mmdvm/TGList-P25.txt -q "http://www.pistar.uk/downloads/TGList_P25.txt"

