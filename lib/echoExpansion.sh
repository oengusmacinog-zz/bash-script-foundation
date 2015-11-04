#!/usr/bin/env bash

# ##################################################
# Global typography library
#
# VERSION 1.0.0
#
# HISTORY:
#
# * October 31, 2015 - v1.0.0  - File Created
#
# ##################################################

# Variables
# ##################################################

# Echo Expansion Type Flags
declare -A is_type_flags=([icon]=false [dark]=false [light]=false [bold]=false [newline]=true [forcelegacy]=false)

# Echo Expansion strings to print
declare ee_icon_str=''
declare ee_bold_str=''
declare ee_color_str=''
declare ee_type_str=''
declare ee_newline_str=''

# Shared Functions
# ##################################################

set_ee_options() {
	# Iterate over options breaking -ab into -a -b when needed and --foo=bar into
	# --foo bar
	optstring=h
	unset options
	while (($#)); do
		case $1 in
			# If option is of type -ab
			-[!-]?*)
				# Loop over each character starting with the second
				for ((i=1; i < ${#1}; i++)); do
					c=${1:i:1}

					# Add current char to options
					options+=("-$c")

					# If option takes a required argument, and it's not the last char make
					# the rest of the string its argument
					if [[ $optstring = *"$c:"* && ${1:i+1} ]]; then
						options+=("${1:i+1}")
						break
					fi
				done
				;;
			# If option is of type --foo=bar
			--?*=*) options+=("${1%%=*}" "${1#*=}") ;;
			# add --endopts for --
			--) options+=(--endopts) ;;
			# Otherwise, nothing special
			*) options+=("$1") ;;
		esac
		shift
	done
	set -- "${options[@]}"
	unset options

	# Read the options and set stuff
	while [[ $1 = -?* ]]; do
		case $1 in
			-i) is_type_flags[icon]=true ;;
			-d) is_type_flags[dark]=true ;;
			-l) is_type_flags[light]=true ;;
			-b) is_type_flags[bold]=true ;;
			-n) is_type_flags[newline]=false ;;
			-f) is_type_flags[forcelegacy]=true ;;
			*) : ;;
		esac
		shift
	done
	ee_type_str=$@
}

reset_ee() {
	is_type_flags[icon]=false
	is_type_flags[dark]=false
	is_type_flags[light]=false
	is_type_flags[bold]=false
	is_type_flags[newline]=true
	is_type_flags[forcelegacy]=false

	ee_icon_str=''
	ee_bold_str=''
	ee_color_str=''
	ee_type_str=''
	ee_newline_str=''
}

# Params: [icon font]
set_ee_icon() {
	if [[ "${is_type_flags[icon]}" = true ]]; then
		ee_icon_str=$1
	else
		ee_icon_str=''
	fi
}

set_ee_bold() {
	if [[ "${is_type_flags[bold]}" = true ]]; then
		ee_bold_str="$(tput bold)"
	else
		ee_bold_str=""
	fi
}

# params: default light dark legacy
set_ee_color () {
	if [[ "${is_type_flags[dark]}" = true ]]; then
		ee_color_str=$3
	elif [[ "${is_type_flags[light]}" = true ]]; then
		ee_color_str=$2
	else
		if [[ "${is_type_flags[forcelegacy]}" = true ]]; then
			ee_color_str=$4
		else	
			ee_color_str=$1
		fi
	fi
}

set_ee_newline() {
	if [[ "${is_type_flags[newline]}" = true ]]; then
		ee_newline_str="\n"
	else
		ee_newline_str=""
	fi
}

# Internal Executables
# ##################################################	

einf() {
	set_ee_options $@

	set_ee_bold
	set_ee_color $T_BLUE $T_CYAN $T_BLUE_DK $T_BLUE_LG
	set_ee_newline

	printf "$ee_bold_str$ee_color_str$ee_type_str$RESET$ee_newline_str"

	reset_ee	
}

ente() {
	set_ee_options $@

	set_ee_bold
	set_ee_color $T_PURPLE $T_PURPLE_LT $T_PURPLE_DK $T_PURPLE_LG
	set_ee_newline

	printf "$ee_bold_str$ee_color_str$ee_type_str$RESET$ee_newline_str"

	reset_ee
}

ewar() {
	set_ee_options $@

	set_ee_icon "➜ "
	set_ee_bold
	set_ee_color $T_YELLOW $T_YELLOW_LT $T_ORANGE $T_YELLOW_LG
	set_ee_newline

	printf "$ee_bold_str$ee_color_str$ee_icon_str$ee_type_str$RESET$ee_newline_str"

	reset_ee
}

esuc() {
	set_ee_options $@

	set_ee_icon "✔ "
	set_ee_bold
	set_ee_color $T_GREEN $T_GREEN $T_GREEN $T_GREEN_LG
	set_ee_newline

	printf "$ee_bold_str$ee_color_str$ee_icon_str$ee_type_str$RESET$ee_newline_str"

	reset_ee
}

eerr() {
	set_ee_options $@

	set_ee_icon "✖ "
	set_ee_bold
	set_ee_color $T_RED $T_RED $T_RED $T_RED_LG
	set_ee_newline

	printf "$ee_bold_str$ee_color_str$ee_icon_str$ee_type_str$RESET$ee_newline_str"

	reset_ee
}

#######################################
# Print variable name and value
# Options:
#   [-g] => Print all global variables 
# Arguments:
#   [$1] => Variable name string (no arguments)
#######################################
evar() {
	if [[ "$@" = '-g' ]]; then
		evar SCRIPT_NAME
		evar SCRIPT_BASE_NAME
		evar NOW
		evar DATE_STAMP
		evar HOUR_STAMP
		evar TIME_STAMP
		evar TODAY
		evar THIS_HOST
		evar CORE_FILE
		evar BIN_PATH
		evar TMP_DIR
		evar LOG_FILE
		return
	fi
	ewar -bn "\$"
	einf -bn "$@: "
	echo "${!@}"
}



