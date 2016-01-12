#!/usr/bin/env bash
SCRIPTS=$(find /vagrant/install/install-* -type f)

for SCRIPT in ${SCRIPTS}; do
  SCRIPT_NAME=$(basename ${SCRIPT})
  echo
  echo
  echo
  echo "#####################################################################"
  echo "### Running ... ${SCRIPT_NAME}"

sudo ${SCRIPT}

  echo "### Finished ... ${SCRIPT_NAME}"
  echo "#####################################################################"
done