FROM ubuntu:zesty

MAINTAINER Philbert Yoon <philbert@felixlab.io>

USER root

# Version dependencies
ENV APACHE_SPARK_VERSION 2.2.0
ENV HADOOP_VERSION 2.7

# Python & JDK installation
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        python-software-properties \
        python3.6 \
        python3.6-venv \
        python3.6-dev \
        openjdk-8-jdk && \
        rm -rf /var/lib/apt/lists/* && \
        rm -rf /var/cache/oracle-jdk8-installer

# Set default Python
RUN update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.6 2
RUN update-alternatives --config python

# Spark installation
RUN cd /tmp && \
    wget -q http://d3kbcqa49mib13.cloudfront.net/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /opt && \
    rm spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

RUN cd /opt && ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark

# Spark config
ENV SPARK_HOME /opt/spark
ENV PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH
ENV SPARK_OPTS --driver-java-options=-Xms512M --driver-java-options=-Xmx2096M --driver-java-options=-Dlog4j.logLevel=error

# entrypoint
ENV APP_HOME /opt/app
ENV PYTHONIOENCODING UTF-8
ADD examples $APP_HOME
WORKDIR $APP_HOME

RUN chmod +x $APP_HOME/entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]