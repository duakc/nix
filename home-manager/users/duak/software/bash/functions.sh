#!/usr/bin/env bash

function getuuid() {
	case "$OSTYPE" in
		darwin*)  local a=$(command uuidgen);echo ${a,,};; 
		linux*)   cat /proc/sys/kernel/random/uuid ;;
  		*)        command -v uuid >/dev/null 2>&1 && command uuid || 
			echo "uuidgen not supported" && return  ;;
	esac
}

function mktmp() {
	local dir_name=mktmp-$(getuuid)
	local dir_path="/tmp/${dir_name}"
	mkdir -p $dir_path && pushd $dir_path
}

function cleantmp() {
	rm -rf /tmp/mktmp-*
}

function lines() {
    local v=0
    [[ "$1" == "-v" ]] && { v=1; shift; }
    [[ -z "$1" ]] && echo "Error: No file suffix set." && return 1

    for s in "$@"; do
        (( v )) && {
            local o=$(find . -type f -name "*.${s}" -exec sh -c '
                for f do l=$(wc -l <"$f" 2>/dev/null) || continue
                printf "%d\t%s\n" "$l" "$f"
                done' _ {} + | sort -t$'\t' -k1nr)
            if [[ -n "$o" ]]; then
                local tl=0 fc=0 l f
                while IFS=$'\t' read -r l f; do ((tl+=l,fc++)); done <<<"$o"
                printf "%s: %d ( %d files )\n" "$s" "$tl" "$fc"
                while IFS=$'\t' read -r l f; do printf "%s: %d\n" "$f" "$l"; done <<<"$o"
            else
                printf "%s: 0 ( 0 files )\n" "$s"
            fi
            :
        } || {
            local t=0 c=0 a b
            while read -r a b; do ((t+=a,c+=b)); done < <(
                find . -type f -name "*.${s}" -exec sh -c '
                    echo $(cat -- "$@" 2>/dev/null | wc -l) $#
                ' _ {} +
            )
            printf "%s: %d ( %d files )\n" "$s" "$t" "$c"
        }
    done
}
