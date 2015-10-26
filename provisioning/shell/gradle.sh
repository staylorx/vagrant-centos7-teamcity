#!/bin/bash

#clear it out to reinstall
rm -rf /tmp/gradle-2.7-bin.zip
wget --progress=bar https://services.gradle.org/distributions/gradle-2.7-bin.zip -O /tmp/gradle-2.7-bin.zip
sudo unzip /tmp/gradle-2.7-bin.zip -d /opt
rm -rf /tmp/gradle-2.7-bin.zip

#tighten up the GRADLE_HOME so the teamcity agent sees it.
printf "export GRADLE_HOME=/opt/gradle-2.7\nexport PATH=\$PATH:\$GRADLE_HOME/bin" > /etc/profile.d/gradle.sh
. /etc/profile.d/gradle.sh

#clean up and head out
hash -r ; sync

# check installation
gradle -v