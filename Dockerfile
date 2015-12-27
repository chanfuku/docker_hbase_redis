# Dockerfile for Hbase StandAloneMode

From centos:centos6.7
MAINTAINER Kohei Ebato

RUN yum -y install wget tar gcc
RUN cd /root && \
 wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.rpm" -O jdk-7u79-linux-x64.rpm && \
 rpm -ivh jdk-7u79-linux-x64.rpm && \
 wget http://ftp.tsukuba.wide.ad.jp/software/apache/hbase/hbase-0.94.27/hbase-0.94.27.tar.gz && \
 tar xzvf hbase-0.94.27.tar.gz && \
 wget http://download.redis.io/releases/redis-3.0.6.tar.gz && \
 tar xzf redis-3.0.6.tar.gz 
RUN cd /root/redis-3.0.6 && make 
RUN echo "export JAVA_HOME=/usr/java/default" >> ~/.bash_profile
RUN echo "export PATH=/root/hbase-0.94.27/bin:$PATH" >> ~/.bash_profile
RUN adduser hbase_user
ADD conf /root/hbase-0.94.27/conf/
ADD schema/hbase.schema /tmp/
RUN source ~/.bash_profile && start-hbase.sh && hbase shell < /tmp/hbase.schema

