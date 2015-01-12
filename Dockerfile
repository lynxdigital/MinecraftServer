# Minecraft Docker Container Build File
# Geoffrey Harrison - 13/01/2015

# Built From Debain Wheezy - Set Maintainer
FROM debian:wheezy
MAINTAINER Geoffrey Harrison <geoffrey.harrison@lynxdigital.com.au>

# Set Minecraft Server Version
ENV MC_VERSION 1.8.1

# Install OpenJDK Java And Wget
RUN apt-get -y update && \
    apt-get -y install openjdk-7-jre-headless wget && \
    apt-get clean autoclean && apt-get autoremove -y && rm -rf /var/lib/{apt,dpkg,cache,log}/ ;

# Add Default Execution Script
ADD scripts/run.sh /usr/local/bin/run

# Download And Install Minecraft Server - Set run Script Permissions
RUN mkdir -p /data /configs /opt/minecraft && \
    wget -O /opt/minecraft/minecraft_server.jar https://s3.amazonaws.com/Minecraft.Download/versions/${MC_VERSION}/minecraft_server.${MC_VERSION}.jar && \
    chmod u+x /usr/local/bin/run ;

# Add Provided Configs To Container
ADD configs/ /configs/

# Export Directories
VOLUME ["/data","/configs"]

# Expose Minecraft Data Port
EXPOSE 25565

# Set Work Directory
WORKDIR /data

# Set Entrypoint and Default Config
ENTRYPOINT ["/usr/local/bin/run"]
CMD ["default"]

