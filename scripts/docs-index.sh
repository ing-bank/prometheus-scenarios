#!/bin/bash

usage() {
    echo """
    This script will adjust the index of each chapter in the scenario.

    Usage: $(basename $0) SCENARIO
        SCENARIO  Name of the scenario
"""
}

#
# MAIN LOGIC
#
if [ -z "$1" ]; then
    usage
    exit 1
fi
# import common
source "$(dirname $0)/common.sh"

README="README.md"
SCENARIO_DOCS="$1/docs"
I="1"
CHAPTERS_COUNT=$(ls $SCENARIO_DOCS | grep "chapter" | wc -l)
while read -r -d ',' chap ; do
    chap_dir="$SCENARIO_DOCS/$chap"
    rf="$chap_dir/$README"
    echo "# Editing $chap_dir"
    content="# Chapter $I  "$'\n'
    while read -r -d ',' f ; do
        url=$(urlencode "$f")
        name=$(echo "$f" | sed 's/^\(.*\)[.]md$/\1/')
        content="${content}[${name}]($url)  "$'\n'
    done <<<$(ls -1 "$chap_dir" | grep -e "^[0-9].*\.md" | sort | tr '\n' ',')

    echo "$content" > $rf
    I=$((I+1))
done <<<$(ls -1 $SCENARIO_DOCS | grep "chapter" | sort | tr '\n' ',')

echo "Done"
