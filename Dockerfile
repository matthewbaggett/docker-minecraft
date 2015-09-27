# Base system is the LTS version of Ubuntu.
FROM   ubuntu:14.04

# Make sure we don't get notifications we can't answer during building.
ENV    DEBIAN_FRONTEND noninteractive

# Download and install everything from the repos.
RUN    apt-get --yes update; apt-get --yes upgrade; apt-get --yes install wget unzip nmap screen software-properties-common
RUN    sudo apt-add-repository --yes ppa:webupd8team/java; apt-get --yes update
RUN    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
       echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
       apt-get --yes install curl oracle-java8-installer

# Download FTBInfinity
RUN wget http://ftb.cursecdn.com/FTB2/modpacks/FTBInfinity/1_10_1/FTBInfinityServer.zip
RUN unzip FTBInfinityServer.zip
RUN chmod +x /*.sh
RUN ./FTBInstall.sh
RUN sed -i 's/false/true/g' /eula.txt

ADD server.properties /server.properties
RUN sed -i 's/server\-port=25565/server\-port=5000/g' /server.properties
RUN sed -i 's/max\-players=20/max\-players=10/g' /server.properties
RUN sed -i 's/motd=A Minecraft Server/motd=A Cloudminer Minecraft Server/g' /server.properties

# 25565 is for minecraft
EXPOSE 5000

# /data contains static files and database
VOLUME ["/data"]

# /start runs it.
CMD    ["/Server.sh"]
