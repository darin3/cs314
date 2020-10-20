# Auto-Deploy Script for CS314
Automate the server deployment process for the CS314 trip project. Works with DEV and SPRINT[1-5] options.

## Script Setup
* Copy deploy.sh to the project **t##/bin/** directory.
* If it is not exectuable, add permissions with **chmod +x deploy.sh**.

## Running
1. From the t## directory, run "./bin/deploy.sh".
1. Follow the prompts. Provide eID (used for ssh/rsync) and server (DEV or SPRINT#).
1. "./bin/run.sh -d" will run automatically if the target directory does not contain a server-*.jar file, otherwise you can optionally skip this command to turn in the current jar in target. 
1. If an error occurs, run "./bin/run.sh -d" normally to check for errors, and make sure port forwarding is working.

## Passwordless SSH Login (optional, but convenient)
* Follow the steps at this [link from linuxize](https://linuxize.com/post/how-to-setup-passwordless-ssh-login/), or there are many other resources.
* If this isn't set up, you will have to **enter your remote machine password twice** (for rsync then ssh commands).

## Warnings
* This script must be run in a **BASH shell**.
* By default, the script **removes all server-*.jar files from the remote server home directory** for clean up.
* This script has only been tested on Fedora and Ubuntu.
* If you are deploying a sprint server, make sure to enter the correct sprint number (eg. SPRINT3) or it won't show up.
