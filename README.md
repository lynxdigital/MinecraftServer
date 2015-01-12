##Minecraft Server Dockerfile
###Introduction
This repository contains the **Dockerfile** and default configuration for Docker's automated build system.

I wrote this to run on my home server as my kids and I love playing Minecraft. This gives us a persistent world we can connect too from multiple devices in our home. Any comments or improvements for the script are welcome.

The Dockerfile is based on "debian wheezy" to keep the image as small as possible. Other components which get installed into the image are:
 - **OpenJDK** - The Java runtime is required to run the Minecraft Server JAR File.
 - **Minecraft Server** - The Minecraft Server JAR File Itself.

###Installation
1. Install [Docker](https://www.docker.com/) Onto Your Distribution
2. Clone This Git Repository
3. Change Into The Cloned Directory And Execute:

> docker build -t [TAG] .

**N.B.** Tag can be any valid Docker Image name you like - I personally use 'minecraft:latest' and will reference this name throughout the rest of the document.

###Usage
To execute a simple container with no persitent data (i.e. for testing purposes):

> docker run -d -p 25565:25565 minecraft

To add some data persistency:

> docker run -d -p 25565:25565 -v /Host/Folder:/data minecraft

###Adding Your Own Minecraft Server World Configurations
When the git repository is cloned, the configs folder contains the default config file as published on the [Minecraft Wiki](http://minecraft.gamepedia.com/Server.properties). You can add your own World config files and execute them in the container instead.
To add your configs into the container before the build - add the configs with a unique name in the configs folder. They will then be included in the docker container on build. To execute the configuration, simply add the name of the properties file to the docker command line.

For example, if you created a server properties file and named it 'peaceful.properties' you can build a new world based on it in a container with:

> docker run -d -p 25565:25565 minecraft peaceful

You can also mount a config folder from the host file system. To execute a new world with persistent data (in a possible production scenario):

> docker run -d -p 25565:25565 -v /Host/Data/Folder:/data -v /Host/Configs/Folder:/configs minecraft [config name]

**N.B.** If the data folder already contains files (e.g. from a previous run), a new config will not be copied.

Using this method, you could potentially store hundreds of different configurations and initiate new worlds by naming the config file you want to use.

###In conclusion...
Any comments or improvement requests are welcome. I'm still new to Minecraft Server and this is just an attempt to make my own life easier.
