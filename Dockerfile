# Base system is the LTS version of Ubuntu.
FROM   ubuntu:14.04

# Make sure we don't get notifications we can't answer during building.
ENV    DEBIAN_FRONTEND noninteractive

# Download and install everything from the repos.
RUN    apt-get --yes update; apt-get --yes upgrade; apt-get --yes install wget unzip nmap screen software-properties-common && \
       sudo apt-add-repository --yes ppa:webupd8team/java; apt-get --yes update && \
       echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
       echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
       apt-get --yes install curl oracle-java8-installer && \
	   rm -Rf /var/cache/apt/archives/*

# Download FTBInfinity
RUN wget http://ftb.cursecdn.com/FTB2/modpacks/FTBInfinity/1_10_1/FTBInfinityServer.zip && unzip FTBInfinityServer.zip -d /data && rm FTBInfinityServer.zip
RUN chmod +x /data/*.sh
RUN cd /data && ./FTBInstall.sh
RUN sed -i 's/false/true/g' /data/eula.txt

ADD Start.sh /data/Start.sh
RUN chmod +x /data/Start.sh
RUN ls -lah /data
ADD server.properties /data/server.properties
RUN sed -i 's/server\-port=25565/server\-port=5000/g' /data/server.properties
RUN sed -i 's/max\-players=20/max\-players=10/g' /data/server.properties
RUN sed -i 's/motd=A Minecraft Server/motd=A Cloudminer Minecraft Server/g' /data/server.properties
RUN cat /data/server.properties

# 25565 is for minecraft
EXPOSE 25565

# /data contains static files and database
VOLUME ["/data"]

# /start runs it.
CMD    ["/data/Start.sh"]
