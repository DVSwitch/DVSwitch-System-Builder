# DVSwitch-System-Builder


# Install DVSwitch Repository

cd /tmp

wget http://dvswitch.org/buster

chmod +x buster

./buster

apt-get update -y

apt-get install dvswitch-server -y

You now have the COMPLETE DVSwitch Server installed. This includes:

The Dashboard
The System Monitor
The configuration menu (dvs)

The dvs menu is not in the path of the Super User. It is in the path of a non-privileged user.
To run dvs as Super User:
cd /usr/local/dvs
./dvs
