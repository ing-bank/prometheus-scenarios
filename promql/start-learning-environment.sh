#!/bin/sh
#
# This script will start the learning environment for PromQL
#
cd "$(dirname $0)"
export PROMQLWD="$(pwd)"
docker ps > /dev/null 2>&1
if test $? -ne 0; then
  echo "Docker does not seem to be running, or you do not have access to use it"
  exit 1
fi
docker-compose up
# end of script