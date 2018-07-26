#! /bin/sh

###################################################
#                                                 #
#                 #
#                                                 #
###################################################

wget -O /var/lib/dvswitch/subscriber_ids.csv -q --no-check-certificate "http://ham-digital.org/status/users.csv"

wget -O /var/lib/dvswitch/peer_ids.csv -q --no-check-certificate "http://ham-digital.org/status/rptrs.csv"


