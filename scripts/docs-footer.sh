#!/bin/bash


usage() {
    echo """
    This script will adjust the footer of each document in the scenario.

    Usage: $(basename $0) SCENARIO
        SCENARIO  Name of the scenario
"""
}


print_footer() {
    file="$1"
    prev="$2"
    next="$3"
    tmp="${file}.tmp"
    nl=$(cat "${file}" | wc -l)
    footer_line=$(grep -n -e "^[-][-][-]" "${file}" || echo "${nl}:" )
    footer_line_nr=$(echo $footer_line | cut -d ':' -f1)
    footer_len=$(($nl - $footer_line_nr + 1))
    if [ -z "$(tail -n $(($footer_len+1)) "$file" | head -1)" ] ; then
        footer_len=$(($footer_len+1))
    fi
    head -n "$(($nl - $footer_len ))" "${file}" > "$tmp"
    echo -n """
---
## [< previous]($prev) | [next >]($next)
""" >> "$tmp"
    mv "$tmp" "$file"
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

SCENARIO_DOCS="$1/docs"
CI="0"
CHAPTERS_COUNT=$(ls $SCENARIO_DOCS | grep "chapter" | wc -l)
while read -r -d ',' chap ; do
    docs_dir="$SCENARIO_DOCS/$chap"
    prev="README.md"
    echo "### Going to edit files in $docs_dir ###"
    
    # read to array does not work on osx :(
    files=()
    while read -r -d ',' f ; do
        files+=("$f")
    done <<<$(ls -1 "$docs_dir" | grep -e "^[0-9].*\.md" | sort | tr '\n' ',')
    len=${#files[@]}
    for (( i=0; i<$len; i++ )); do
        f=${files[$i]}
        echo "### Editing ${f}"
        # if file is last then next points to next chapter
        if [ $i -eq $(($len-1)) ]; then
            next=$(urlencode "..")
        else
            ni=$(($i+1))
            next=$(urlencode "${files[$ni]}")
        fi 
        
        print_footer "$docs_dir/${f}" $prev $next
        prev=$(urlencode "${f}")
        
    done #end for loop 
done <<<$(ls -1 $SCENARIO_DOCS | grep "chapter" | sort | tr '\n' ',')

echo "Done"
