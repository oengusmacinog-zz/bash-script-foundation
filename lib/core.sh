#!/usr/bin/env bash

# ##################################################
# The core library file for sourcing
#
# VERSION 1.0.0
#
# HISTORY:
#
# * October 31, 2015 - v1.0.0  - File Created
#
# ##################################################

# Logging with Colors
# ##################################################
# Set the colors for our script feedback levels.
#
# Usage:
#    success "sometext"
# ##################################################

alert_msg() {
	# Set log message colors based on severity
	case $TERM in
	    xterm*|rxvt*)
	        case $1 in
	        	emergency)
					local color="\e[1;31m" #red bold
					;;
	        	error)
					local color="\e[0;31m" #red
					;;
	        	success)
					local color="\e[0;32m" #green
					;;
	        	debug)
					local color="\e[0;35m" #purple
					;;
	        	header)
					local color="\e[1;34m" #yellow
					;;
				warning)
					local color="\e[0;33m" #yellow
					;;
	        	input)
					local color="\e[1;37m"
					print_log="0"
					;;
	        	info|notice)
					local color="" # Us terminal default color
					;;
			esac
			local reset="\e[0m"
			;;
	    *)
	        local color=""
	        local reset=""
	        ;;
	esac

	# Print to $logFile
	if [[ ${print_log} = "true" ]] || [ "${print_log}" == "1" ]; then
		echo -e "$(date +"%m-%d-%Y %r") $(printf "[%9s]" ${1}) "${2}"" >> "${LOG_FILE}";
	fi

	# Print to console when script is not 'quiet'
	if [[ "${quiet}" = "true" ]] || [ ${quiet} == "1" ]; then
		return
	else
		echo -e "$(date +"%r") ${color}$(printf "[%9s]" ${1}) "${2}"${reset}";
	fi
}

die ()       { echo "$(alert_msg emergency "${@}")"; safe_exit;}
error ()     { echo "$(alert_msg error "${@}")"; }
warning ()   { echo "$(alert_msg warning "${@}")"; }
notice ()    { echo "$(alert_msg notice "${@}")"; }
info ()      { echo "$(alert_msg info "${@}")"; }
debug ()     { echo "$(alert_msg debug "${@}")"; }
success ()   { echo "$(alert_msg success "${@}")"; }
input()      { echo -n "$(alert_msg input "${@}")"; }
header()     { echo "$(alert_msg header "========== ${@} ==========  ")"; }

# Log messages when verbose is set to "true"
# ##################################################
verbose() {
	if [[ "${verbose}" = "true" ]] || [ ${verbose} == "1" ]; then
		debug "$@"
	fi
}

# Source additional /lib files
# ##################################################
# First we locate this script and populate the
# $SCRIPT_PATH variable. Doing so allows us to 
# source additional files from this core file.
# ##################################################

SOURCE="${BASH_SOURCE[0]}"
while [ -h "${SOURCE}" ]; do # resolve ${SOURCE} until the file is no longer a symlink
	DIR="$( cd -P "$( dirname "${SOURCE}" )" && pwd )"
	SOURCE="$(readlink "${SOURCE}")"
	[[ ${SOURCE} != /* ]] && SOURCE="${DIR}/${SOURCE}" # if ${SOURCE} was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SOURCE_PATH="$( cd -P "$( dirname "${SOURCE}" )" && pwd )"

if [ ! -d "${SOURCE_PATH}" ]; then
	die "Failed to find library files expected in: ${SOURCE_PATH}"
	exit 1
fi
for core_file in "${SOURCE_PATH}"/*.sh; do
	if [ -e "${core_file}" ]; then
		# Don't source self
		if [[ "${core_file}" == *"core.sh"* ]]; then
			continue
		fi
		source "$core_file"
	fi
done
