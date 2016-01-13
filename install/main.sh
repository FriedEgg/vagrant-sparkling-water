#!/bin/bash

### Configuration
#####################################################################
JAVA_VER_MAJOR=7
JAVA_VER_MINOR=80
JAVA_VER_EXTRA=b15
JAVA_VER_OTHER=${JAVA_VER_MAJOR}u${JAVA_VER_MINOR}
JAVA_VERSION=jdk1.${JAVA_VER_MAJOR}.0_${JAVA_VER_MINOR}
JAVA_ARCHIVE=jdk-${JAVA_VER_OTHER}-linux-x64.tar.gz
JAVA_MIRROR_DOWNLOAD=http://download.oracle.com/otn-pub/java/jdk/${JAVA_VER_OTHER}-${JAVA_VER_EXTRA}/${JAVA_ARCHIVE}
JAVA_HOME=/usr/local/java

HADOOP_VERSION=hadoop-2.6.3
HADOOP_ARCHIVE=${HADOOP_VERSION}.tar.gz
HADOOP_MIRROR_DOWNLOAD=http://archive.apache.org/dist/hadoop/core/${HADOOP_VERSION}/${HADOOP_ARCHIVE}
HADOOP_CONF_DIR=/etc/hadoop/conf

SPARK_VER_MAJOR=1.5
SPARK_VER_MINOR=1
SPARK_VER_OTHER="spark-${SPARK_VER_MAJOR}.${SPARK_VER_MINOR}"
SPARK_PACKAGE=hadoop2.6
SPARK_VERSION="${SPARK_VER_OTHER}-bin-${SPARK_PACKAGE}"
SPARK_ARCHIVE=${SPARK_VERSION}.tgz
SPARK_MIRROR_DOWNLOAD=http://archive.apache.org/dist/spark/${SPARK_VER_OTHER}/${SPARK_ARCHIVE}
SPARK_CONF_DIR=/usr/local/$SPARK_VERSION/conf

SPARKLING_WATER_VER_MAJOR=1.5
SPARKLING_WATER_VER_MINOR=9
SPARKLING_WATER_VERSION=sparkling-water-${SPARKLING_WATER_VER_MAJOR}.${SPARKLING_WATER_VER_MINOR}
SPARKLING_WATER_ARCHIVE=${SPARKLING_WATER_VERSION}.zip
SPARKLING_WATER_MIRROR_DOWNLOAD=http://h2o-release.s3.amazonaws.com/sparkling-water/rel-${SPARKLING_WATER_VER_MAJOR}/${SPARKLING_WATER_VER_MINOR}/${SPARKLING_WATER_ARCHIVE}

DEBIAN_FRONTEND=noninteractive

### Functions
#####################################################################
function _fmt ()      {
  color_ok="\x1b[32m"
  color_bad="\x1b[31m"

  color="${color_bad}"
  if [ "${1}" = "info" ]; then
    color="${color_ok}"
  fi

  color_reset="\x1b[0m"
  if [ "${TERM}" != "xterm" ] || [ -t 1 ]; then
    # Don't use colors on pipes or non-recognized terminals
    color=""
    color_reset=""
  fi
  echo -e "$(date -u +"%Y-%m-%d %H:%M:%S UTC") ${color}$(printf "[%4s]" ${1})${color_reset}";
}

function warn () { echo "$(_fmt warn) ${@}" 1>&2; }
function info () { echo "$(_fmt info) ${@}" 1>&2; }


function resourceExists () {
FILE=/vagrant/resources/$1
if [ -e $FILE ]; then
  return 0
else
  return 1
fi
}

function setupSlaves () {
info "Modifying spark slaves configuration"
touch $1/slaves
for i in $(seq $2 $3); do
  entry="slave${i}.vm-cluster.com"
  info "... adding ${entry}"
  echo "${entry}" >> $1/slaves
done
}

set -e
set -o pipefail