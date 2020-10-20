#!/bin/bash

# Author: Darin Harter
# Email: darinh@cs.colostate.edu

EXIT_SUCCESS=0
EXIT_ERROR=1
MACHINE="phoenix"

if [ ! -d "bin/" ]
then
  echo "Error: deploy.sh should be located in 'bin' and run with ./bin/deploy.sh"
  exit $EXIT_ERROR
fi

echo "** Warning: any server-#.jar files in the home directory of the remote machine will be deleted (for clean up). **"
echo -n "eID: "
read -r eid
echo -n "Target (DEV or SPRINT#): "
read -r server

if [[ ! $server =~ ^(DEV|SPRINT[1-5])$ ]]; then
  echo "Invalid server '$server'. Valid options: DEV or SPRINT[1-5]."
  exit $EXIT_ERROR
fi

rebuild="y"
if [ -d "target" ]; then
  # only give option to not rebuild if target directory exists
  echo -n "Rebuild jar? (recommended) [y/n]: "
  read -r rebuild
fi

if [[ $rebuild =~ ^[yY]$ ]]; then
  echo "Building project with './run.sh -d'"
  if ! ./bin/run.sh -d >/dev/null 2>&1
  then
    printf "Error when executing command: '%s'\n" "$0"
    printf "  Run './bin/run.sh -d' normally to check for errors or failed tests.\n"
    printf "  Reminder: set up port forwarding if needed.\n"
    exit $EXIT_ERROR
  fi
fi

echo "Copying server-#.jar to CSU machine."
if ! rsync target/server-*.jar "${eid}@${MACHINE}.cs.colostate.edu:"
then
  echo "Error: rsync failed, could not copy jar to remote machine."
  exit $EXIT_ERROR
fi

echo "Running \"~cs314/bin/checkin ${server} server-*.jar\""
echo "Deleting jar file."

if ! ssh "${eid}@${MACHINE}.cs.colostate.edu" "~cs314/bin/checkin ${server} server-*.jar; rm server-*.jar"
then
  echo "Error: there was a problem with ssh or ~cs314/bin/checkin."
  exit $EXIT_ERROR
fi

echo ""
echo "Server deployed to ${server}!"
exit $EXIT_SUCCESS
