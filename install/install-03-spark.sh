#!/bin/bash
source "/vagrant/install/main.sh"

function installSpark {
echo
echo
info "### Installing Spark"
info "#####################################################################"

info "Setting up environment variables"

cat >> /etc/profile.d/spark.sh << EOF
export SPARK_HOME=/usr/local/spark
export MASTER="yarn-client"
export PATH=\${SPARK_HOME}/bin:\${SPARK_HOME}/sbin:\${PATH}
export SPARK_CONF_DIR=$SPARK_CONF_DIR
EOF

if resourceExists $SPARK_ARCHIVE; then
  info "Installing from local file"
else
  info "Installing from remote file"
  curl -sS -o /vagrant/resources/$SPARK_ARCHIVE -O -L $SPARK_MIRROR_DOWNLOAD
fi

FILE=/vagrant/resources/$SPARK_ARCHIVE
info "Extracting Archive $FILE"
tar -xf $FILE -C /usr/local

info "Creating spark directories"

mkdir -p $SPARK_CONF_DIR

info "Copying spark configuration files"

cp -f /vagrant/resources/spark/* $SPARK_CONF_DIR

ln -s /usr/local/$SPARK_VERSION /usr/local/spark
}

installSpark