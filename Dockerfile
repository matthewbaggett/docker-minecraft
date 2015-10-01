# Base system is the LTS version of Ubuntu.
FROM   phusion/baseimage:latest

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
RUN wget http://servers.technicpack.net/Technic/servers/tekkit-legends/Tekkit_Legends_Server_v1.0.6.zip && unzip Tekkit_Legends_Server_v1.0.6.zip -d /data && rm Tekkit_Legends_Server_v1.0.6.zip
WORKDIR /data
RUN mkdir /data/plugins && cd /data/plugins && wget http://dev.bukkit.org/media/files/837/363/worldedit-bukkit-6.0.jar
RUN cd /data/mods && wget http://addons-origin.cursecdn.com/files/2223/999/Dynmap-2.1-forge-1.7.10.jar

ADD ops.txt /data/ops.txt
ADD server.properties /data/server.properties
ADD start-server.sh /data/start-server.sh

RUN chmod +x /data/start-server.sh

# 25565 is for minecraft
EXPOSE 25565 8123

# /data contains static files and database
VOLUME ["/data"]

# /start runs it.
CMD    ["/data/start-server.sh"]
