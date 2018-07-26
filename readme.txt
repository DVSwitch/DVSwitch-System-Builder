This will help me (you) add the needed directories, scripts to a existing Debian install.
This is not a how to, this is not a ready to run image. This is how I layout a MMDVM system.
Everything is built from source. This is as about as brute force as it gets. Can these steps be done 
better programmatically? Yes. Feel free to modify to taste.

/opt/program_name	This is where I keep the programs and config files. Example /opt/MMDVMHost
/var/lib/mmdvm		This is where I keep the data files. Example /var/lib/mmdvm/DMRIDs.dat
/var/log/mmdvm		This is where the programs put their log files
/usr/local/sbin		This is where I put the needed scripts
/lib/systemd/system	This is where I put the systemd unit files for start / stop
/etc/cron.daily		This is symbolic links to the scripts that need to run daily
/srv			This is where I checkout the needed git repositories


I have tried to follow the Linux Standard Base (LSB) specifically, the Filesystem Hierarchy Standard (FHS)
You could make a case that the data files do not belong in /var/lib, and I might agree. I borrowed this structure from asterisk.

I keep the configuration file with the program in /opt. The program is started with the name of the config file on the command line.
Example MMDVMHost MMDVM.ini Again, you could make a case for placement of the config files in /etc I felt /etc was too crowded now.
Throuout the config files the callsign is W1AW and the ID is 1234567 I suggest you change these. Strongly!

The data files needed like DMRIds.dat are kept in /var/lib/mmdvm. I also place the host files and any other "changeable" data.
These files can be replaced by download scripts. If needed the download script is responseable for restarting the application.

I keep all the log files together in /var/log/mmdvm. This will make it easier to find the log and to cleanup as needed.

Any added scripts are in /usr/local/sbin

I use systemd to start, stop and run on system boot. The unit files are built to not start the programs until the internet is available.
I also do not start MMDVMHost until the modem is available. I prefer this to timers.

Scripts are run daily to update the needed data files. There are symbolic links to /usr/local/sbin for those scripts that are run by cron.

I download and git clone to /srv. I usually copy the source directories to /usr/src to compile the programs. The executable is copied to /opt/program_name. 

I will be adding the tools and directories needed to compile and install the firmware to the MMDVM boards. (modems and hot spots)

This is a work in progress and is mostly so I can easily recreate a system. I seem to do this a LOT!

73, Steve N4IRS

