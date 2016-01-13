#!/bin/bash
source "/vagrant/install/main.sh"

function installSparklingWater {
echo
echo
info "--- Installing Sparkling Water"
info "---------------------------------------------------------------------"

info "Setting up environment variables"

echo "export SPARKLING_WATER_HOME=/usr/local/sparkling-water" >> /etc/profile.d/spark.sh
echo "export PATH=\${SPARKLING_WATER_HOME}/bin:\${PATH}" >> /etc/profile.d/spark.sh

if resourceExists $SPARKLING_WATER_ARCHIVE; then
  info "Installing from local file"
else
  warn "Installing from remote file.  This may take some time."
  curl -sS -o /vagrant/resources/$SPARKLING_WATER_ARCHIVE -O -L $SPARKLING_WATER_MIRROR_DOWNLOAD
fi

FILE=/vagrant/resources/$SPARKLING_WATER_VERSION
info "Extracting Archive $FILE"
unzip -q -d /usr/local $FILE

ln -s /usr/local/$SPARKLING_WATER_ARCHIVE /usr/local/sparkling-water
}

installSparklingWater