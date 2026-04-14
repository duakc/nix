#!/usr/bin/env bash

function getuuid() {
	case "$OSTYPE" in
		darwin*)  local a=$(command uuidgen);echo ${a,,};; 
		linux*)   cat /proc/sys/kernel/random/uuid ;;
  		*)        echo "uuidgen not supported" && exit 1  ;;
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
