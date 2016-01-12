#!/bin/bash
source "/vagrant/install/main.sh"
START=3
TOTAL_SLAVES=2

while getopts s:t: option; do
  case "${option}" in
    s) START=${OPTARG};;
    t) TOTAL_SLAVES=${OPTARG};;
  esac
done

setupSlaves $SPARK_CONF_DIR $START $TOTAL_SLAVES