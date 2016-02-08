sudo apt-get update && sudo apt-get install oracle-java7-jdk

sudo mkdir /opt/mongodb
cd /opt/mongodb
sudo wget https://github.com/brice-morin/ArduPi/blob/master/mongodb-rpi/mongo/bin/bsondump?raw=true -O bsondump
sudo wget https://github.com/brice-morin/ArduPi/blob/master/mongodb-rpi/mongo/bin/mongo?raw=true -O mongo
sudo wget https://github.com/brice-morin/ArduPi/blob/master/mongodb-rpi/mongo/bin/mongod?raw=true -O mongod
sudo wget https://github.com/brice-morin/ArduPi/blob/master/mongodb-rpi/mongo/bin/mongodump?raw=true -O mongodump
sudo chmod +x *


unzip UniFi.unix.zip
sudo mv UniFi /opt/UniFi

cd /opt/UniFi/bin
sudo ln -fs /opt/mongodb/mongod mongod


sudo java -jar /opt/UniFi/lib/ace.jar start
sudo java -jar /opt/UniFi/lib/ace.jar start &
sudo java -jar /opt/UniFi/lib/ace.jar stop


cat > /etc/init.d/uniPi < EOF
#!/bin/bash
#
# /etc/init.d/UniFi -- startup script for Ubiquiti UniFi
#
#
### BEGIN INIT INFO
# Provides:          unifi
# Required-Start:    $local_fs $remote_fs $network
# Required-Stop:     $local_fs $remote_fs $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Ubiquiti UniFi
# Description:       Ubiquiti UniFi Controller
### END INIT INFO

NAME="unifi"
DESC="Ubiquiti UniFi Controller"

BASEDIR="/opt/UniFi"
MAINCLASS="com.ubnt.ace.Launcher"

PIDFILE="/var/run/${NAME}/${NAME}.pid"
PATH=/bin:/usr/bin:/sbin:/usr/sbin

JAVA_HOME=/usr/lib/jvm/jdk-7-oracle-armhf
# JSVC - for running java apps as services
JSVC=`which jsvc`
#JSVC_OPTS="-debug"
JSVC_OPTS="${JSVC_OPTS}\
 -home ${JAVA_HOME} \
 -cp /usr/share/java/commons-daemon.jar:${BASEDIR}/lib/ace.jar \
 -pidfile ${PIDFILE} \
 -procname ${NAME} \
 -outfile SYSLOG \
 -errfile SYSLOG \
 -Djava.awt.headless=true -Xmx384M"

[ -f /etc/default/rcS ] && . /etc/default/rcS
. /lib/lsb/init-functions

[ -d /var/run/${NAME} ] || mkdir -p /var/run/${NAME}
cd ${BASEDIR}

is_not_running() {
        start-stop-daemon --test --start --pidfile "${PIDFILE}" \
                --startas "${JAVA_HOME}/bin/java" >/dev/null
        RC=$?
        return ${RC}
}

case "$1" in
        start)
                log_daemon_msg "Starting ${DESC}" "${NAME}"
                if is_not_running; then
                        ${JSVC} ${JSVC_OPTS} ${MAINCLASS} start
                        sleep 1
                        if is_not_running; then
                                log_end_msg 1
                        else
                                log_end_msg 0
                        fi
                else
                        log_progress_msg "(already running)"
                        log_end_msg 1
                fi
        ;;
        stop)
                log_daemon_msg "Stopping ${DESC}" "${NAME}"
                if is_not_running; then
                        log_progress_msg "(not running)"
                else
                        ${JSVC} ${JSVC_OPTS} -stop ${MAINCLASS} stop
                fi
                log_end_msg 0
        ;;
        status)
                status_of_proc -p ${PIDFILE} unifi unifi && exit 0 || exit $?
        ;;
        restart|reload|force-reload)
                if ! is_not_running ; then
                        if which invoke-rc.d >/dev/null 2>&1; then
                                invoke-rc.d ${NAME} stop
                        else
                                /etc/init.d/${NAME} stop
                        fi
                fi
                if which invoke-rc.d >/dev/null 2>&1; then
                        invoke-rc.d ${NAME} start
                else
                        /etc/init.d/${NAME} start
                fi
        ;;
        *)
                log_success_msg "Usage: $0 {start|stop|restart|reload|force-reload}"
                exit 1
        ;;
esac

exit 0
EOF


#This script uses jsvc, which we'll need to install. Run:
sudo apt-get update && sudo apt-get install jsvc

#Enable execution of the script and make it run at boot time:
sudo chmod +x /etc/init.d/unifi
sudo update-rc.d unifi defaults
