#! /bin/sh

###################################################
#                                                 #
# Download Subscriber IDs for NXDN                #
#                                                 #
###################################################

curl -s -N https://www.radioid.net/api/nxdn/user/?id=% | jq -r '.results[] | [.id, .callsign, .fname] | @csv' | sed -e 's/"//g' > /var/lib/mmdvm/nxdn.csv
