#!/bin/bash

set -e

FILE=/config/opt/nessus/sbin/nessusd
if test -f "$FILE"; then
echo "Nessus is already setup"
else

# Setup permissions
echo "Setting user permissions..."
if [[ "$PUID" ]]
then
	echo "Modifying ID for nobody."
	usermod -a -G users -o -u "$PUID" nobody &>/dev/null
fi

if [[ "$PGID" ]]
then
	echo "Modifying ID for the users group."
	groupmod -o -g "$PGID" users &>/dev/null
fi

# Add DNS resolvers
echo "Adding nameservers to /etc/resolv.conf..."
echo 'nameserver 9.9.9.9' >> /etc/resolv.conf
echo 'nameserver 149.112.112.112' >> /etc/resolv.conf

# Extract nessus to either upgrade, or place initial install files
echo "Extracting packaged nessus debian package"
dpkg -x /tmp/Nessus-10.6.0-ubuntu1404_amd64.deb /config

# Set permissions on configuration files
echo "Changing owner and group of configuration files..."
chown -R nobody:users /config

# With nessus installed to the volume path; create symbolic links
echo "Creating symbolic links..."
ln -s /config/opt/nessus/sbin/nessusd /etc/init.d/nessusd
ln -s /config/opt/nessus/ /opt/nessus
fi

# Start the nessusd process
echo "Starting Nessus"
/config/opt/nessus/sbin/nessus-service
