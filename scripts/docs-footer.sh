#!/bin/bash


usage() {
    echo """
    This script will adjust the footer of each document in the scenario.

    Usage: $(basename $0) SCENARIO
        SCENARIO  Name of the scenario
"""
}

urlencode() {
    # urlencode <string>
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:$i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf '%s' "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done

    LC_COLLATE=$old_lc_collate
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
    head -n "$(($nl - $footer_len ))" "${file}" > "$tmp"
    echo -n """---
## [< previous]($prev) | [next >]($next)
""" >> "$tmp"
    mv "$tmp" "$file"
}



if [ -z "$1" ]; then
    usage
    exit 1
fi

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
    done <<<$(ls -1 "$docs_dir" | grep ".md" | grep -v "README" | sort | tr '\n' ',')
    len=${#files[@]}
    for (( i=0; i<$len; i++ )); do
        f=${files[$i]}
        echo "### Editing ${f}"
        # if file is last then next points to next chapter
        if [ $i -eq $(($len-1)) ]; then
            next=$(urlencode $SCENARIO_DOCS)
        else
            ni=$(($i+1))
            next=$(urlencode "${files[$ni]}")
        fi 
        
        print_footer "$docs_dir/${f}" $prev $next
        prev=$(urlencode "${f}")
        
    done #end for loop 
done <<<$(ls -1 $SCENARIO_DOCS | grep "chapter" | sort | tr '\n' ',')

echo "Done"
