#!/bin/bash

set -o pipefail -e

JRE_TEMPLATE="Dockerfile.jre.tpl"
JDK_TEMPLATE="Dockerfile.jdk.tpl"
JDK_DCEVM_TEMPLATE="Dockerfile.jdk-dcevm.tpl"
MAKE_TEMPLATE="Makefile.tpl"

JAVA_VERSIONS=( 7-80-15 8-77-03 )

for version in ${JAVA_VERSIONS[@]}; do
  JVM_MAJOR=$(echo $version | cut -d- -f1)
  JVM_MINOR=$(echo $version | cut -d- -f2)
  JVM_BUILD=$(echo $version | cut -d- -f3)

  echo -en "Generating Dockerfile for ${JVM_MAJOR}u${JVM_MINOR}b${JVM_BUILD} JRE.. "
  sed "s/%JVM_MAJOR%/$JVM_MAJOR/g;s/%JVM_MINOR%/$JVM_MINOR/g;s/%JVM_BUILD%/$JVM_BUILD/g;s/%JVM_PACKAGE%/server-jre/g" $JRE_TEMPLATE > $JVM_MAJOR/jre/Dockerfile && \
    echo "done" || \
    echo "failed"

  echo -en "Generating Makefile for ${JVM_MAJOR}u${JVM_MINOR}b${JVM_BUILD} JRE.. "
  sed "s/%JVM_MAJOR%/$JVM_MAJOR/g;s/%JVM_MINOR%/$JVM_MINOR/g;s/%JVM_BUILD%/$JVM_BUILD/g;s/%JVM_PACKAGE%/server-jre/g" $MAKE_TEMPLATE > $JVM_MAJOR/jre/Makefile && \
    echo "done" || \
    echo "failed"

  echo -en "Generating Dockerfile for ${JVM_MAJOR}u${JVM_MINOR}b${JVM_BUILD} JDK.. "
  sed "s/%JVM_MAJOR%/$JVM_MAJOR/g;s/%JVM_MINOR%/$JVM_MINOR/g;s/%JVM_BUILD%/$JVM_BUILD/g;s/%JVM_PACKAGE%/jdk/g" $JDK_TEMPLATE > $JVM_MAJOR/jdk/Dockerfile && \
    echo "done" || \
    echo "failed"

  echo -en "Generating Makefile for ${JVM_MAJOR}u${JVM_MINOR}b${JVM_BUILD} JDK.. "
  sed "s/%JVM_MAJOR%/$JVM_MAJOR/g;s/%JVM_MINOR%/$JVM_MINOR/g;s/%JVM_BUILD%/$JVM_BUILD/g;s/%JVM_PACKAGE%/jdk/g" $MAKE_TEMPLATE > $JVM_MAJOR/jdk/Makefile && \
    echo "done" || \
    echo "failed"

  echo -en "Generating Dockerfile for ${JVM_MAJOR}u${JVM_MINOR}b${JVM_BUILD} JDK with DCEVM .. "
  if [ "$JVM_MAJOR" -eq "7" ]; then
	  DCEVM_INSTALLER_URL="https:\\/\\/github.com\\/dcevm\\/dcevm\\/releases\\/download\\/full-jdk7u79%2B8\\/DCEVM-full-7u79-installer.jar"
	  DCEVM_INSTALLER_NAME="DCEVM-full-7u79-installer.jar"
  else
	  DCEVM_INSTALLER_URL="https:\\/\\/github.com\\/dcevm\\/dcevm\\/releases\\/download\\/light-jdk8u74%2B1\\/DCEVM-light-8u74-installer.jar"
	  DCEVM_INSTALLER_NAME="DCEVM-light-8u74-installer.jar"
  fi 
  sed "s/%JVM_MAJOR%/$JVM_MAJOR/g;s/%JVM_MINOR%/$JVM_MINOR/g;s/%JVM_BUILD%/$JVM_BUILD/g;s/%JVM_PACKAGE%/jdk/g;s/%DCEVM_INSTALLER_URL%/$DCEVM_INSTALLER_URL/g;s/%DCEVM_INSTALLER_NAME%/$DCEVM_INSTALLER_NAME/g" $JDK_DCEVM_TEMPLATE > $JVM_MAJOR/jdk-dcevm/Dockerfile && \
    echo "done" || \
    echo "failed"

done
