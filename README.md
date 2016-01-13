vagrant-sparkling-water
===

# Introduction

Vagrant project to create a cluster of virtual machines with Hadoop, Spark and Sparkling Water

By default, there are 4 nodes

1. master : 2x vcpu, 4096mb, HDFS NameNode + Spark Master + YARN ResourceManager + JobHistoryServer + ProxyServer
2. slave1 : 1x vcpu, 2048mb, HDFS DataNode + YARN NodeManager + Spark Slave
3. slave1 : 1x vcpu, 2048mb, HDFS DataNode + YARN NodeManager + Spark Slave
4. slave1 : 1x vcpu, 2048mb, HDFS DataNode + YARN NodeManager + Spark Slave

# Getting Started

1. [Download and install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Download and install Vagrant](http://www.vagrantup.com/downloads.html)
3. Git clone this project, and change directory (cd) into this project (directory)
4. Run ```vagrant up``` to create the VM
5. Run ```vagrant ssh master``` to get into your VM
6. Run ```vagrant destroy``` when you want to destroy and get rid of the VM

### Test YARN
Run the following command to make sure you can run a MapReduce job.

```
yarn jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.6.3.jar pi 2 100
```

### Test Spark on YARN
You can test if Spark can run on YARN by issuing the following command.  Try NOT to run this command on the slave nodes.

```
$SPARK_HOME/bin/spark-submit --class org.apache.spark.examples.SparkPi \
  --master yarn \
  --num-executors 10 \
  --executor-cores 2 \
  $SPARK_HOME/lib/spark-examples*.jar \
  100
```

### Test code directly on Spark
```
$SPARK_HOME/bin/spark-submit --class org.apache.spark.examples.SparkPi \
  --master spark://master.vm-cluster.com \
  --num-executors 10 \
  --executor-cores 2 \
  $SPARK_HOME/lib/spark-examples*.jar \
  100
```

### Test Spark using Shell
Start the Spark shell using the following command.  Try NOT to run this command on the slave nodes.

```
$SPARK_HOME/bin/spark-shell --master spark://master.vm-cluster.com:7077
```

### Test Sparklink Water
You can test if Sparkling Water can run on YARN by issuing the following command.  Try NOT to run this command on the slave nodes.

```
$SPARKLING_WATER_HOME/bin/run-example DeepLearningDemo
```

# Web UI
You can check the following URLs to monitor the Hadoop daemons.

1. [NameNode](http://10.211.55.100:50070/dfshealth.html)
2. [ResourceManager](http://10.211.55.100:8088/cluster)
3. [JobHistory](http://10.211.55.100:19888/jobhistory)
4. [Spark](http://10.211.55.100:8080)
5. [Spark History](http://10.211.55.100:18080)

# Thanks To
* [arjones](https://github.com/arjones/vagrant-spark-zeppelin)
* [vangj](https://github.com/vangj/vagrant-hadoop-2.4.1-spark-1.0.1)