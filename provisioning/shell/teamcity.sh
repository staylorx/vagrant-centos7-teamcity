#!/usr/bin/env bash

#ensure these match the jboss-as script in /etc/init.d
export TEAMCITY_HOME=/opt/TeamCity
export TEAMCITY_DATA_PATH=/var/TeamCity
export TEAMCITY_USER=teamcity
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.60-2.b27.el7_1.x86_64
TEAMCITY_TAR_FILE=/tmp/TeamCity-9.1.3.tar.gz

rm -rf $TEAMCITY_TAR_FILE
cp /vagrant_data/provided_packages/TeamCity-9.1.3.tar.gz $TEAMCITY_TAR_FILE
# an alternative to keeping a local copy of the binaries is to fetch it here.
# wget http://download.jetbrains.com/teamcity/TeamCity-9.1.3.tar.gz $TEAMCITY_TAR_FILE

echo 'untarring teamcity...'
rm -rf /opt/TeamCity
tar xfz $TEAMCITY_TAR_FILE -C /opt
rm -rf $TEAMCITY_TAR_FILE

#copy startup properties
cp /vagrant_data/provisioning/resources/teamcity-startup.properties $TEAMCITY_HOME/conf

echo 'copying standalone service file into init.d'
rm -rf /etc/init.d/teamcity
cp /vagrant_data/provisioning/resources/teamcity-initd-script /etc/init.d/teamcity
chmod 0755 /etc/init.d/teamcity

chkconfig --add teamcity
service teamcity start

#echo 'optionally reenable firewalld or iptables...'
#systemctl start firewalld
#systemctl enable firewalld
