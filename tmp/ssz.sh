#!/bin/bash

###############################################################################
#
# mmdvmmenu.sh
#
# Copyright (C) 2016 by Paul Nannery KC2VRJ
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
###############################################################################
#
# On a Linux based system, such as a Raspberry Pi, this script will perform
# Modification of the Config.h file for most options. It makes a Back up when
# you start the script if none is present. You must recompile and load firmware
# onto the Arduino Due if changes are made.
#
###############################################################################
#
#                              CONFIGURATION
#
# Location of Config.h
conf=Config.h
#Location of backup file
confbak=Config.h.bak

################################################################################
#
# Do not edit below here
#
###############################################################################



# Check for backup file and make one if not present

if [ ! -f $confbak ];then

cp -f $conf $confbak

fi

while :
do
    clear
    cat<<EOF
    ==============================================================
                       Compile MMDVM Menu
    --------------------------------------------------------------
    Please enter your choice:

    (1) Build MMDVM-Pi board
    (2) Build MMDVM-Pi F722 board
    (3) Build MMDVM-F4M board
    (4) Build STM32F722-F7M board
    (5) Build Nucleo64 F446RE board
    (6) Build Discovery board
    (7) Build Nucleo144 F767ZI board
    (8) Build STM32F4-DVM board
    (9) Build
    (0) Build
    (A) Return to Default

                         (Q)uit
    ---------------------------------------------------------------
EOF
    read -n1 -s
    case "$REPLY" in
    "1")  make pi;;
    "2")  make pi-f722;;
    "3")  make f4m;;
    "4")  make f7m;;
    "5")  make nucleo;;
    "6")  make dis;;
    "7")  make f767;;
    "8")  make dvm;;
    "9")  echo "9";;
    "0")  echo "0";;
    "A")  echo "A";;
    "a")  echo "a";;
    "Q")  echo "If any changes are made you need to (re-)upload the firmware to MMDVM" && exit;;
    "q")  echo "If any changes are made you need to (re-)upload the firmware to MMDVM" && exit;;
     * )  echo "invalid option"     ;;
    esac
    sleep 1
done

# make pi         # MMDVM-Pi board
# make pi-f722    # MMDVM-Pi F722 board
# make f4m        # MMDVM-F4M board
# make f7m        # STM32F722-F7M board
# make nucleo     # Nucleo64 F446RE board
# make dis        # Discovery board
# make f767       # Nucleo144 F767ZI board
# make dvm        # STM32F4-DVM board

