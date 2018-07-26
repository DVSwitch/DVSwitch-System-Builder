#!/usr/bin/env bash
# set -o errexit

# N4IRS 07/26/2017

#################################################
#                                               #
#                                               #
#                                               #
#################################################

# NXDNGateway-2018-06-10.log
ls NXDNGateway-????-??-??.log | head -n-7 | xargs rm
ls P25Gateway-????-??-??.log | head -n-7 | xargs rm
ls YSFGateway-????-??-??.log | head -n-7 | xargs rm
ls YSF2DMR-????-??-??.log | head -n-7 | xargs rm
ls YSF2NXDN-????-??-??.log | head -n-7 | xargs rm
ls YSF2P25-????-??-??.log | head -n-7 | xargs rm
