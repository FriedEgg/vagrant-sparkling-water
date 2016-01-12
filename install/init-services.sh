#!/usr/bin/env bash
source "/vagrant/install/main.sh"

function formatNameNode {
info "format namenode"
$HADOOP_PREFIX/bin/hdfs namenode -format myhadoop -force -noninteractive
}

function startHdfs {
info "starting hdfs"
$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode
$HADOOP_PREFIX/sbin/hadoop-daemons.sh --config $HADOOP_CONF_DIR --script hdfs start datanode
}

function startYarn {
info "starting yarn"
$HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start resourcemanager
$HADOOP_YARN_HOME/sbin/yarn-daemons.sh --config $HADOOP_CONF_DIR start nodemanager
$HADOOP_YARN_HOME/sbin/yarn-daeomon.sh start proxyserver --config $HADOOP_CONF_DIR
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
startSpark
createEventLogDir
startSpark