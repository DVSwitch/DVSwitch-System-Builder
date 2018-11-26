#! /bin/sh

###################################################
#                                                 #
#                 #
#                                                 #
###################################################

wget -O /var/lib/dvswitch/subscriber_ids.csv -q --no-check-certificate "https://www.radioid.net/static/users.csv"

wget -O /var/lib/dvswitch/peer_ids.csv -q --no-check-certificate "https://www.radioid.net/static/rptrs.csv"


