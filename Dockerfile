FROM ubuntu:14.04

ENV SHELL /bin/bash

RUN apt-get update
RUN apt-get install -y software-properties-common curl

# JAVA         
RUN apt-add-repository -y ppa:webupd8team/java
RUN apt-get update
#Auto Accept licenses
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
#Install
RUN apt-get install -y oracle-java8-installer scala
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
#Update path
ENV PATH $PATH:$JAVA_HOME/bin

# SPARK
ARG SPARK_ARCHIVE=http://www.mirrorservice.org/sites/ftp.apache.org/spark/spark-2.2.0/spark-2.2.0-bin-hadoop2.7.tgz
RUN curl -s $SPARK_ARCHIVE | tar -xz -C /usr/local/

ENV SPARK_HOME /usr/local/spark-2.2.0-bin-hadoop2.7
ENV PATH $PATH:$SPARK_HOME/bin

#COPY ha.conf $SPARK_HOME/conf

EXPOSE 4040 6066 7077 8080

WORKDIR $SPARK_HOME
