#!/bin/bash
#########################################################
#                                                       #
#              HostFilesUpdate.sh Updater               #
#                                                       #
#      Written for Pi-Star (http://www.pistar.uk/)      #
#               By Andy Taylor (MW0MWZ)                 #
#                                                       #
#                     Version 2.45                      #
#                                                       #
#   Based on the update script by Tony Corbett G0WFV    #
#   Tweaks by N4IRS. Don't blame Tony or Andy           #
#                                                       #
#########################################################

# Check that the network is UP and die if its not
if [ "$(expr length `hostname -I | cut -d' ' -f1`x)" == "1" ]; then
	exit 0
fi

APRSHOSTS=/var/lib/mmdvm/APRSHosts.txt
DCSHOSTS=/var/lib/mmdvm/DCS_Hosts.txt
DExtraHOSTS=/var/lib/mmdvm/DExtra_Hosts.txt
DMRIDFILE=/var/lib/mmdvm/DMRIds.dat
DMRHOSTS=/var/lib/mmdvm/DMR_Hosts.txt
DPlusHOSTS=/var/lib/mmdvm/DPlus_Hosts.txt
P25HOSTS=/var/lib/mmdvm/P25Hosts.txt
YSFHOSTS=/var/lib/mmdvm/YSFHosts.txt
FCSHOSTS=/var/lib/mmdvm/FCSHosts.txt
XLXHOSTS=/var/lib/mmdvm/XLXHosts.txt
NXDNIDFILE=/var/lib/mmdvm/NXDN.csv
NXDNHOSTS=/var/lib/mmdvm/NXDNHosts.txt
TGLISTBM=/var/lib/mmdvm/TGList_BM.txt
TGLISTP25=/var/lib/mmdvm/TGList_P25.txt
TGLISTNXDN=/var/lib/mmdvm/TGList_NXDN.txt
TGLISTYSF=/var/lib/mmdvm/TGList_YSF.txt

# How many backups
FILEBACKUP=1

# Check we are root
if [ "$(id -u)" != "0" ];then
	echo "This script must be run as root" 1>&2
	exit 1
fi

# Create backup of old files
if [ ${FILEBACKUP} -ne 0 ]; then
	cp ${APRSHOSTS} ${APRSHOSTS}.$(date +%Y%m%d)
	cp ${DCSHOSTS} ${DCSHOSTS}.$(date +%Y%m%d)
	cp ${DExtraHOSTS} ${DExtraHOSTS}.$(date +%Y%m%d)
	cp ${DMRIDFILE} ${DMRIDFILE}.$(date +%Y%m%d)
	cp ${DMRHOSTS} ${DMRHOSTS}.$(date +%Y%m%d)
	cp ${DPlusHOSTS} ${DPlusHOSTS}.$(date +%Y%m%d)
	cp ${P25HOSTS} ${P25HOSTS}.$(date +%Y%m%d)
	cp ${YSFHOSTS} ${YSFHOSTS}.$(date +%Y%m%d)
	cp ${FCSHOSTS} ${FCSHOSTS}.$(date +%Y%m%d)
	cp ${XLXHOSTS} ${XLXHOSTS}.$(date +%Y%m%d)
	cp ${NXDNIDFILE} ${NXDNIDFILE}.$(date +%Y%m%d)
	cp ${NXDNHOSTS} ${NXDNHOSTS}.$(date +%Y%m%d)
	cp ${TGLISTBM} ${TGLISTBM}.$(date +%Y%m%d)
	cp ${TGLISTP25} ${TGLISTP25}.$(date +%Y%m%d)
	cp ${TGLISTNXDN} ${TGLISTNXDN}.$(date +%Y%m%d)
	cp ${TGLISTYSF} ${TGLISTYSF}.$(date +%Y%m%d)
fi

# Prune backups
FILES="${APRSHOSTS}
${DCSHOSTS}
${DExtraHOSTS}
${DMRIDFILE}
${DMRHOSTS}
${DPlusHOSTS}
${P25HOSTS}
${YSFHOSTS}
${FCSHOSTS}
${XLXHOSTS}
${NXDNIDFILE}
${NXDNHOSTS}
${TGLISTBM}
${TGLISTP25}
${TGLISTNXDN}
${TGLISTYSF}"

for file in ${FILES}
do
  BACKUPCOUNT=$(ls ${file}.* | wc -l)
  BACKUPSTODELETE=$(expr ${BACKUPCOUNT} - ${FILEBACKUP})
  if [ ${BACKUPCOUNT} -gt ${FILEBACKUP} ]; then
	for f in $(ls -tr ${file}.* | head -${BACKUPSTODELETE})
	do
		rm $f
	done
  fi
done

# Generate Host Files
curl --fail -o ${APRSHOSTS} -s http://www.pistar.uk/downloads/APRS_Hosts.txt
curl --fail -o ${DCSHOSTS} -s http://www.pistar.uk/downloads/DCS_Hosts.txt
curl --fail -o ${DMRHOSTS} -s http://www.pistar.uk/downloads/DMR_Hosts.txt
if [ -f /etc/hostfiles.nodextra ]; then
  # Move XRFs to DPlus Protocol
  curl --fail -o ${DPlusHOSTS} -s http://www.pistar.uk/downloads/DPlus_WithXRF_Hosts.txt
  curl --fail -o ${DExtraHOSTS} -s http://www.pistar.uk/downloads/DExtra_NoXRF_Hosts.txt
else
  # Normal Operation
  curl --fail -o ${DPlusHOSTS} -s http://www.pistar.uk/downloads/DPlus_Hosts.txt
  curl --fail -o ${DExtraHOSTS} -s http://www.pistar.uk/downloads/DExtra_Hosts.txt
fi
curl --fail -o ${DMRIDFILE} -s http://www.pistar.uk/downloads/DMRIds.dat
curl --fail -o ${P25HOSTS} -s http://www.pistar.uk/downloads/P25_Hosts.txt
curl --fail -o ${YSFHOSTS} -s http://www.pistar.uk/downloads/YSF_Hosts.txt
curl --fail -o ${FCSHOSTS} -s http://www.pistar.uk/downloads/FCS_Hosts.txt
#curl --fail -s http://www.pistar.uk/downloads/USTrust_Hosts.txt >> ${DExtraHOSTS}
curl --fail -o ${XLXHOSTS} -s http://www.pistar.uk/downloads/XLXHosts.txt
curl --fail -o ${NXDNIDFILE} -s http://www.pistar.uk/downloads/NXDN.csv
curl --fail -o ${NXDNHOSTS} -s http://www.pistar.uk/downloads/NXDN_Hosts.txt
curl --fail -o ${TGLISTBM} -s http://www.pistar.uk/downloads/TGList_BM.txt
curl --fail -o ${TGLISTP25} -s http://www.pistar.uk/downloads/TGList_P25.txt
curl --fail -o ${TGLISTNXDN} -s http://www.pistar.uk/downloads/TGList_NXDN.txt
curl --fail -o ${TGLISTYSF} -s http://www.pistar.uk/downloads/TGList_YSF.txt

exit 0
