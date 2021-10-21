

urlencode() {
    # urlencode <string>
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C
    s="$1"
    if [ -z "$s" ]; then
        read -r s
    fi
    local length="${#s}"

    for (( i = 0; i < length; i++ )); do
        local c="${s:$i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf '%s' "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done

    LC_COLLATE=$old_lc_collate
}

