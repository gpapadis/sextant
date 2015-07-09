FROM ubuntu:14.04
MAINTAINER George Papadakis <gpapadis@di.uoa.gr>

ENV TOMCAT_VERSION 7 

RUN apt-get update && apt-get install -y \
           default-jdk \
           maven\
           mercurial \
           tomcat$TOMCAT_VERSION\
           && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN hg clone 'http://hg.strabon.di.uoa.gr/Sextant-New' && \
           cd Sextant-New/JerseyServer/ && \
           mvn clean package

RUN cp /Sextant-New/JerseyServer/target/*.war /var/lib/tomcat$TOMCAT_VERSION/webapps/.  && \
	rm -Rf /Sextant-New

EXPOSE 8080
ENTRYPOINT [ "/usr/share/tomcat"$TOMCAT_VERSION"/bin/catalina.sh", "run"]
