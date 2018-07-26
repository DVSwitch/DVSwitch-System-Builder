#! /bin/sh

###################################################
#                                                 #
# Download Subscriber IDs for YSF2DMR             #
#                                                 #
###################################################

# TGList_BM.txt downloaded from http://www.pistar.uk/downloads/TGList_BM.txt
# All BrandMeister TG and Reflectors for use with YSF2DMR
# Sourced from https://api.brandmeister.network/v1.0/groups/
# Please report issues at https://www.facebook.com/groups/pistar/
# File created at Saturday 10th of March 2018 01:21:12 AM UTC
#
# Dest ID;Option;Name;Description
#
# Option: TG:0, REF:1, PC:2
#
# TGListFile=TGList-DMR.txt

wget -O /var/lib/mmdvm/TGList-DMR.txt -q "http://www.pistar.uk/downloads/TGList_BM.txt"

