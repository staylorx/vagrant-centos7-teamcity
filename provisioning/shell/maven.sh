#!/bin/bash

#clear it out to reinstall
FILE_NAME=apache-maven-3.3.3-bin.tar.gz
rm -rf /tmp/$FILE_NAME
wget --progress=bar http://supergsego.com/apache/maven/maven-3/3.3.3/binaries/$FILE_NAME -O /tmp/$FILE_NAME
tar xfz /tmp/$FILE_NAME -C /opt
rm -rf /tmp/$FILE_NAME

#tighten up the MAVEN_HOME so the teamcity agent sees it.
printf "export MAVEN_HOME=/opt/apache-maven-3.3.3\nexport PATH=\$PATH:\$MAVEN_HOME/bin" > /etc/profile.d/maven.sh
. /etc/profile.d/maven.sh

#clean up and head out
hash -r ; sync

mvn -v