#!/bin/bash
source "/vagrant/install/main.sh"

while getopts t: option; do
  case "${option}" in
    t) TOTAL_SLAVES=${OPTARG};;
  esac
done

function setupHosts {
info "Modifying /etc/hosts file"
info "adding master.vm-cluster.com master"
echo "10.211.55.100 master.vm-cluster.com master" >> /etc/hosts
for i in $(seq 1 $TOTAL_SLAVES); do
  entry="10.211.55.10${i} slave${i}.vm-cluster.com slave${i}"
  info "adding ${entry}"
  echo "${entry}" >> /etc/hosts
done
}

setupHosts