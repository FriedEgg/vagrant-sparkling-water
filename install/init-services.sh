#!/usr/bin/env bash
source "/vagrant/install/main.sh"

function formatNameNode {
info "format namenode"
$HADOOP_PREFIX/bin/hdfs namenode -format myhadoop -force -noninteractive
}

function startHdfs {
info "starting hdfs"
$HADOOP_PREFIX/sbin/start-dfs.sh --config $HADOOP_CONF_DIR
}

function startYarn {
info "starting yarn"
$HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start resourcemanager
$HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start nodemanager
$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver --config $HADOOP_CONF_DIR
}

function createEventLogDir {
hdfs dfs -mkdir /tmp
hdfs dfs -mkdir /tmp/spark-events
info "created spark event log dir"
}

function startSpark {
info "starting spark"
$SPARK_HOME/sbin/start-all.sh
$SPARK_HOME/sbin/start-history-server.sh
}

formatNameNode
startHdfs
startYarn
createEventLogDir
startSpark