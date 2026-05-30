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
    [[ -z "$1" ]] && echo "Error: No file suffix set." && return

    find . -type f -name "*.${1}" -exec sh -c '
        # 对传入的这批文件一次性统计行数和文件个数
        # 注意：无读权限的文件会被 cat 跳过，行数会被忽略
	
        total=$(cat -- "$@" 2>/dev/null | wc -l)
        echo "$total $#"
    ' _ {} + | awk '{t+=$1; c+=$2} END{print t, "(" c " files)"}'
}
