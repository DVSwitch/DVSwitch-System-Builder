#! /bin/sh

###################################################
#                                                 #
#                 #
#                                                 #
###################################################

curl -s -N https://www.radioid.net/api/dmr/user/?id=% | jq -r '.results[] | [.id, .callsign, .fname] | @csv' | sed -e 's/"//g' > /var/lib/dvswitch/subscriber_ids.csv

curl -s -N https://www.radioid.net/static/rptrids_simple_cbridge.csv | sed 's/- //g' | sed 's/,.*//g' | sed -r 's/([a-zA-Z0-9]+) ([a-zA-Z0-9]+)/\2 \1/g' > /var/lib/dvswitch/peer_ids.csv
