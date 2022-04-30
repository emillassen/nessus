# Nessus
Docker container for Nessus 10.

This docker is aligned to utilize Ubuntu 22.04 LTS with the corresponding Nessus .deb file. 

The Nessus file can be downloaded from here: https://www.tenable.com/downloads/nessus
Nessus-XXXX-ubuntu1110_amd64.deb


To build:
-Clone repository and download the Nessus.deb file for 64-bit Ubuntu 20.04 placing it in the config directory
-Verify the Nessus.deb statement in the dockerfile (and setup.sh file) align with the correct version
-Run the command: docker build -t nessus

For pulling off dockerhub, the following command can be used to include setting permissions, volume mappings, and port mapping.
docker run -d --name nessus --mount source=nessus,target=/config -e PUID=99 -e PGID=100 -p 8834:8834 emillassen/nessus
