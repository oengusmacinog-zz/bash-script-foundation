#!/usr/bin/env bash

# ##################################################
# Global variables for library
#
# VERSION 1.0.0
#
# HISTORY:
#
# * October 31, 2015 - v1.0.0  - File Created
#
# ##################################################

# Script Name
# ##################################################
# Will return the name of the script being run
# ##################################################
declare -r SCRIPT_NAME="$(basename $0)"                                    # Set Script Name variable
declare -r SCRIPT_BASE_NAME="$(basename ${SCRIPT_NAME} .sh)"               # Strips '.sh' from scriptName

# Timestamps
# ##################################################
# Prints the current date and time in a variety of 
# formats:
# ##################################################
declare -r NOW=$(date +"%m-%d-%Y %r")                                      # Returns: 06-14-2015 10:34:40 PM
declare -r DATE_STAMP=$(date +%Y-%m-%d)                                    # Returns: 2015-06-14
declare -r HOUR_STAMP=$(date +%r)                                          # Returns: 10:34:40 PM
declare -r TIME_STAMP=$(date +%Y%m%d_%H%M%S)                               # Returns: 20150614_223440
declare -r TODAY=$(date +"%m-%d-%Y")                                       # Returns: 06-14-2015

# This Host
# ##################################################
# Will print the current hostname of the computer 
# the script is being run on.
# ##################################################
declare -r THIS_HOST=$(hostname)

# Color Palette
# ##################################################
# Colors Could be 2, 8, 16, 88 and 256 are common 
# values
# ##################################################
declare -r T_BLUE="$(tput setaf 32)"
declare -r T_BLUE_DK="$(tput setaf 12)"
declare -r T_CYAN="$(tput setaf 6)"
declare -r T_BLUE_LG="$(tput setaf 4)"
declare -r T_PURPLE="$(tput setaf 171)"
declare -r T_PURPLE_DK="$(tput setaf 141)"
declare -r T_PURPLE_LT="$(tput setaf 13)"
declare -r T_PURPLE_LG="$(tput setaf 5)"
declare -r T_YELLOW="$(tput setaf 184)"
declare -r T_YELLOW_LT="$(tput setaf 226)"
declare -r T_ORANGE="$(tput setaf 172)"
declare -r T_YELLOW_LG="$(tput setaf 3)"
declare -r T_RED="$(tput setaf 9)"
declare -r T_RED_LG="$(tput setaf 1)"
declare -r T_GREEN="$(tput setaf 76)"
declare -r T_GREEN_LG="$(tput setaf 2)"
declare -r RESET="$(tput sgr0)"
