#!/bin/sh

# Download latest v3 release
fetch "https://radarr.servarr.com/v1/update/nightly/updatefile?os=linux&runtime=netcore&arch=x64" -o /usr/local/share/tmp.tar.gz
tar -xzvf /usr/local/share/tmp.tar.gz -C /usr/local/share
rm /usr/local/share/tmp.tar.gz

# Create user
pw user add radarr -c radarr -u 352 -d /nonexistent -s /usr/bin/nologin
mkdir /config
chown -R radarr:radarr /usr/local/share/Radarr /config

#Set write permission to be able to write plugins update
chmod 755 /usr/local/share/Radarr

# Start the services
chmod u+x /etc/rc.d/radarr
sysrc -f /etc/rc.conf radarr_enable="YES"
service radarr start

echo "Radarr successfully installed" > /root/PLUGIN_INFO
