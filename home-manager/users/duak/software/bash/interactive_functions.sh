#!/usr/bin/env bash

function uuidgen() {
	case "$OSTYPE" in
		darwin*)  command uuidgen;; 
		linux*)   cat /proc/sys/kernel/random/uuid ;;
  		*)        echo "uuidgen not supported" && exit 1  ;;
	esac
}

function mktmp() {
	local dir_name=mktmp-$(uuidgen)
	local dir_path="/tmp/${dir_name}"
	mkdir -p $dir_path && pushd $dir_path
}

function cleantmp() {
	rm -rf /tmp/mktmp-*
}
