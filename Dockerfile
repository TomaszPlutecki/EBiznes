FROM debian:wheezy 

ENV ASSETS_DIR="/opt/smartentry/HEAD"
ENV SBT_VERSION 1.0.4

COPY smartentry.sh /sbin/smartentry.sh

ENTRYPOINT ["/sbin/smartentry.sh"]

CMD ["run"]

# Java
RUN apt-get update && \
	 apt-get install -y default-jdk && \
	 apt-get install -y wget && \
	 apt-get install -y curl && \
	 apt-get install -y default-jre

# Scala
RUN apt-get remove scala-library scala && \
	 wget www.scala-lang.org/files/archive/scala-2.11.8.deb
	
RUN dpkg -i scala-2.11.8.deb && \
	 apt-get update && \
	 apt-get install -y scala


# SBT
 Run wget -O- "https://github.com/sbt/sbt/releases/download/v0.13.15/sbt-0.13.15.tgz" \
    |  tar xzf - -C /usr/local --strip-components=1 \
    && sbt exit
VOLUME /app
WORKDIR /app
CMD ["sbt"]
