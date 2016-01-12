#!/bin/bash
source "/vagrant/install/main.sh"

function installHadoop {
echo
echo
info "--- Installing Hadoop"
info "---------------------------------------------------------------------"

info "Setting up environment variables"

cat > /etc/profile.d/hadoop.sh << EOF
export HADOOP_PREFIX=/usr/local/hadoop
export HADOOP_YARN_HOME=\${HADOOP_PREFIX}
export HADOOP_CONF_DIR=${HADOOP_CONF_DIR}
export YARN_LOG_DIR=\${HADOOP_YARN_HOME}/logs
export YARN_IDENT_STRING=root
export HADOOP_MAPRED_IDENT_STRING=root
PATH=\${HADOOP_PREFIX}/bin:\${HADOOP_PREFIX}/sbin:\${PATH}
EOF

if resourceExists $HADOOP_ARCHIVE; then
  info "Installing from local file"
else
  warn "Installing from remote file.  This may take some time."
  curl -sS -o /vagrant/resources/$HADOOP_ARCHIVE -O -L $HADOOP_MIRROR_DOWNLOAD
fi

FILE=/vagrant/resources/$HADOOP_ARCHIVE
info "Extracting Archive $FILE"
tar -xf $FILE -C /usr/local

info "Creating hadoop directories"

mkdir -p $HADOOP_CONF_DIR
mkdir -p /var/hadoop
mkdir -p /var/hadoop/hadoop-datanode
mkdir -p /var/hadoop/hadoop-namenode
mkdir -p /var/hadoop/mr-history
mkdir -p /var/hadoop/mr-history/done
mkdir -p /var/hadoop/mr-history/tmp

info "Copying hadoop configuration files"

cp -f /usr/local/$HADOOP_VERSION/etc/hadoop/* $HADOOP_CONF_DIR
cp -f /vagrant/resources/hadoop/* $HADOOP_CONF_DIR
mv $HADOOP_CONF_DIR/slaves $HADOOP_CONF_DIR/slaves.example
echo "master.vm-cluster.com" >> $HADOOP_CONF_DIR/masters

ln -s /usr/local/$HADOOP_VERSION /usr/local/hadoop
}

installHadoop
