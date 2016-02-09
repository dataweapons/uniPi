http://string-functions.com/hex-string.aspx

su - _unifi
ftp https://github.com/unifi-hackers/unifi-lab/archive/master.tar.gz


 Installation of UniFi on OpenBSD 5.5

## 5.4 version of this howto is at https://arnor.org/OpenBSD/unifi_install_openbsd_54.txt

#First, create a dedicated user for this service
groupadd -g 555 -L daemon _unifi
useradd -g 555 -u 555 -m -d /var/unifi -L daemon -c 'Unifi daemon' -s /bin/ksh _unifi

#Add the required packages for building and running UniFi
export PKG_PATH=ftp://ftp.eu.openbsd.org/pub/OpenBSD/`uname -r`/packages/`uname -m`/
pkg_add jre unzip mongodb

#Begin to install things as the dedicated user
su - _unifi

#Protect the directory
chmod 0700 /var/unifi

#The Unifi package has to be downloaded (please read the EULA)
ftp http://dl.ubnt.com/unifi/3.1.13/UniFi.unix.zip

#export java path
cd
echo "export PATH=$PATH:/usr/local/jre-1.7.0/bin" >> .profile
. ./.profile

#Just install and start UniFi package
unzip UniFi.unix.zip
rm -f UniFi/bin/mongod && ln -s /usr/local/bin/mongod UniFi/bin/mongod
cd UniFi
nohup java -jar lib/ace.jar start &

#Add some small security to the files permissions
find /var/unifi/ | xargs chmod o-rwx
find /var/unifi/ | xargs chmod g-rwx

#Become root again to allow starting it automatically on reboot
exit

#Make it run on reboot
cat <<EOF >>/etc/rc.local
if [ -e /var/unifi/UniFi/lib/ace.jar ]; then
        su - _unifi -c "cd /var/unifi/UniFi && nohup /usr/local/jre-1.7.0/bin/java -jar lib/ace.jar start &"
fi
EOF

#Make yourself the dedicated user
su - _unifi

#Stop UniFi
pkill java

#The Unifi package has to be downloaded (please read the EULA)
ftp http://dl.ubnt.com/unifi/3.2.1/UniFi.unix.zip

# save old config, install new version
mv UniFi/data .
rm -rf UniFi
unzip UniFi.unix.zip
rm -f UniFi/bin/mongod && ln -s /usr/local/bin/mongod UniFi/bin/mongod
mv data UniFi

# Start UniFi again
cd UniFi
nohup java -jar lib/ace.jar start &

#Add some small security to the files permissions
find /var/unifi/ | xargs chmod o-rwx
find /var/unifi/ | xargs chmod g-rwx

exit
