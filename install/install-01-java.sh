#!/bin/bash
source "/vagrant/install/main.sh"

function installJava {
  echo
  echo
  info "--- Installing Java"
  info "---------------------------------------------------------------------"

  info "Setting up environment variables"

  echo "export JAVA_HOME=${JAVA_HOME}" >> /etc/profile.d/java.sh
  echo "export PATH=\${JAVA_HOME}/bin:\${PATH}" >> /etc/profile.d/java.sh

  if resourceExists $JAVA_ARCHIVE; then
    info "Installing from local file"
  else
    info "Installing from remote file"
    curl -sS -o /vagrant/resources/$JAVA_ARCHIVE -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k $JAVA_MIRROR_DOWNLOAD
  fi

  FILE=/vagrant/resources/$JAVA_ARCHIVE
  info "Extracting Archive $FILE"
  tar -xf $FILE -C /usr/local

  ln -s /usr/local/$JAVA_VERSION $JAVA_HOME
}

installJava