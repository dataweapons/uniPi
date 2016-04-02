#!/bin/sh

tgts="/usr/lib/unifi/bin/unifi.init /etc/systemd/system/unifi.service /lib/systemd/system/unifi.service /var/lib/unifi /var/log/unifi /var/run/unifi /usr/lib/unifi/work"
for f in ${tgts} ; do
 cp -v ${f} ${f}.$$
done
 
sudo sed -i 's@^set_java_home$@#set_java_home\n\n# Use Oracle Java 8 JVM instead.\nJAVA_HOME=/usr/lib/jvm/jdk-8-oracle-arm-vfp-hflt@' /usr/lib/unifi/bin/unifi.init

sudo cp -v /lib/systemd/system/unifi.service /etc/systemd/system/
sudo sed -i '/^\[Service\]$/a Environment=JAVA_HOME=/usr/lib/jvm/jdk-8-oracle-arm-vfp-hflt' /etc/systemd/system/unifi.service

sudo sed -i 's@-Xmx1024M@-Xmx384M@' /usr/lib/unifi/bin/unifi.init
sudo sed -i 's@-Xmx1024M@-Xmx768M@' /usr/lib/unifi/bin/unifi.init

sudo chown -vR unifi:unifi /var/lib/unifi /var/log/unifi /var/run/unifi /usr/lib/unifi/work
sudo sed -i '/^\[Service\]$/a User=unifi' /etc/systemd/system/unifi.service

sudo echo 'ENABLE_MONGODB=no' | sudo tee -a /etc/mongodb.conf > /dev/null
