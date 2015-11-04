#!/usr/bin/env bash

# ##################################################
# Library of functions that check for information
#
# VERSION 1.0.0
#
# HISTORY:
#
# * November 2, 2015 - v0.0.1-alpha  - Project Initialization
#
# ##################################################

# Test whether a command exists
# ##################################################
# Usage:
#    if type_exists 'git'; then
#      some action
#    else
#      some other action
#    fi
# ##################################################

type_exists() {
	if [ $(type -P "$1") ]; then
		return 0
	fi
	return 1
}

type_not_exists() {
	if [ ! $(type -P "$1") ]; then
		return 0
	fi
	return 1
}

# File Checks
# ##################################################
# A series of functions which make checks against 
# the filesystem. For use in if/then statements.
#
# Usage:
#    if is_file "file"; then
#       ...
#    fi
# ##################################################

is_exists() {
	if [[ -e "$1" ]]; then
		return 0
	fi
	return 1
}

is_not_exists() {
	if [[ ! -e "$1" ]]; then
		return 0
	fi
	return 1
}

is_file() {
	if [[ -f "$1" ]]; then
		return 0
	fi
	return 1
}

is_not_file() {
	if [[ ! -f "$1" ]]; then
		return 0
	fi
	return 1
}

is_dir() {
	if [[ -d "$1" ]]; then
		return 0
	fi
	return 1
}

is_not_dir() {
	if [[ ! -d "$1" ]]; then
		return 0
	fi
	return 1
}

is_symlink() {
	if [[ -L "$1" ]]; then
		return 0
	fi
	return 1
}

is_not_symlink() {
	if [[ ! -L "$1" ]]; then
		return 0
	fi
	return 1
}

is_empty() {
	if [[ -z "$1" ]]; then
		return 0
	fi
	return 1
}

is_not_empty() {
	if [[ -n "$1" ]]; then
		return 0
	fi
	return 1
}

# Test which OS the user runs
# ##################################################
#
# Arguments:
#   [$1] => 'OS to test' string  
# Usage: 
#    if is_os 'linux-gnu'; then
#       ...
#    fi
# ##################################################

is_os() {
	if [[ "${OSTYPE}" == $1* ]]; then
		return 0
	fi
	return 1
}