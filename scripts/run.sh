#!/bin/bash

# Set Config Variable
MC_CONFIG=$(echo ${1:-default} | tr "[:upper:]" "[:lower:]")

## Prepare Data Files
cd /data
# Setup Empty JSON Files
for X in banned-ips banned-players ops whitelist
do
  if [ ! -f ${X}.json ]
  then 
    touch ${X}.json
  fi
done

# Agree To EULA
if [ ! -f eula.txt ]
then
  echo eula=true > /data/eula.txt
fi

# Copy Selected Config To Data Folder
if [ ! -f server.properties ]
then
  cp /configs/${MC_CONFIG}.properties /data/server.properties
fi

# Execute Minecraft Server
exec /usr/bin/java -jar /opt/minecraft/minecraft_server.jar nogui

