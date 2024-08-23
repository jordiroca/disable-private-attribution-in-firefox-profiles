#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# shellcheck shell=bash
#
# DESCRIPTION: disable-private-attribution-in-firefox-profiles.sh description
#
# VERSION: 0.0.1
#
# OPTIONS:
#   -h, --help    Display this message.
#
# AUTHOR: Jordi Roca
# CREATED: 2024/08/23 11:29
#
# GITHUB: https://github.com/jordiroca/
# WEBSITE: https://jordiroca.com
#
# LICENSE: See LICENSE file.
#

# Modify this folder
FFFolder=$HOME/Library/Application\ Support/Firefox/Profiles
# Prefs file
PREFSFILENAME=prefs.js

ANSI_BOLD=$(tput bold)
ANSI_RED=$(tput setaf 1)
ANSI_GREEN=$(tput setaf 2)
ANSI_YELLOW=$(tput setaf 3)
ANSI_BLUE=$(tput setaf 4)
ANSI_MAGENTA=$(tput setaf 5)
ANSI_CYAN=$(tput setaf 6)
ANSI_WHITE=$(tput setaf 7)
ANSI_RESET=$(tput sgr0)

usage()
{
    cat <<EOF

${ANSI_GREEN}$(basename "$0")${ANSI_RESET} by Jordi Roca

Utility to disable the "Private Attribution" setting in all Firefox profiles.

${ANSI_GREEN}What is Private Attribution?${ANSI_RESET}

Firefox has a setting in about:config called ${ANSI_YELLOW}dom.private-attribution.submission.enabled${ANSI_RESET}.

${ANSI_WHITE}Purpose:${ANSI_RESET} This setting is part of Firefox's efforts to support privacy-friendly ways for advertisers and websites to measure ad effectiveness without compromising user privacy.
${ANSI_WHITE}Function:${ANSI_RESET} When enabled, it allows Firefox to participate in the Private Attribution reporting process, which helps measure ad conversions while preserving user privacy.
${ANSI_WHITE}Privacy focus:${ANSI_RESET} The system is designed to provide useful data to advertisers and websites without allowing them to track individual users across sites.
${ANSI_WHITE}Experimental feature:${ANSI_RESET} This is part of ongoing work in web standards and browser implementations to balance marketing needs with user privacy.

${ANSI_WHITE}Default state:${ANSI_RESET} As of the 23rd of August, 2024, this setting was ${ANSI_GREEN}enabled${ANSI_RESET} in all my Firefox profiles.

This script has only been tested for Firefox v129.0 in macOS in August 2024

EOF

}

usage

# check it's darwin
if [ "$(uname -s)" != "Darwin" ]; then
    echo "${ANSI_RED}ERROR:${ANSI_RESET} This script is only for macOS"
    echo "Please, adapt the script to your system it in other systems."
    echo
    exit 1
fi

# ask do you want to proceed?
read -p "Do you want to proceed? (y/n) " -n 1 -r

echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo 
    echo "${ANSI_YELLOW}Hasta luego, Lucas!${ANSI_RESET}"
    echo
    exit 1
fi

if [ ! -d "$FFFolder" ]; then
    echo "${ANSI_RED}ERROR:${ANSI_RESET} Firefox folder not found"
    echo "Are you sure you have Firefox installed?"
    echo
    exit 1
fi

echo 'user_pref("dom.private-attribution.submission.enabled", false);' | tee -a "${FFFolder}"/*/"${PREFSFILENAME}" > /dev/null

echo
echo "${ANSI_BOLD}Restart Firefox for the change to have effect${ANSI_RESET}"
echo
