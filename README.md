# Deploy Script for CS314
Automate the server deployment process

## Script Setup
* Copy deploy.sh to the project **t##/bin/** directory.
* If it is not exectuable, add permissions with **chmod +x deploy.sh**.

## Running
1. From the t## directory, run "./bin/deploy.sh"
1. Follow the prompts. Provide eID (used for ssh/rsync) and server (DEV or SPRINT#)
1. If an error occurs, run "./bin/run.sh -d" normally to check for errors, and make sure port forwarding is working.

## Passwordless SSH Login (optional, but convenient)
* Follow the steps at this [link from linuxize](https://linuxize.com/post/how-to-setup-passwordless-ssh-login/).
* If this isn't set up, you will have to **enter your remote machine password twice** (for rsync then ssh commands).

## Warnings
* This script must be run in a **BASH shell**.
* By default, the script **removes all server-*.jar files from the remote server home directory** for clean up.
* This script has only been tested on Fedora and Ubuntu.
