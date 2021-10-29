#!/bin/sh
#
# This script will start the learning environment for PromQL
#
cd "$(dirname $0)"
export PROMQLWD="$(pwd)"
docker-compose up
# end of script