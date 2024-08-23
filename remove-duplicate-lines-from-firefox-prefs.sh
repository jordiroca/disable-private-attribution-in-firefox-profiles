#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# shellcheck shell=bash
#
# DESCRIPTION: remove-duplicate-lines-from-firefox-prefs Remove duplicate lines from Firefox prefs.js files
#
# VERSION: 0.0.1
#
# OPTIONS:
#   -h, --help    Display this message.
#
# AUTHOR: Jordi Roca
# CREATED: 2024/08/23 13:18
#
# GITHUB: https://github.com/jordiroca/
# WEBSITE: https://jordiroca.com
#
# LICENSE: See LICENSE file.
#

# Modify this folder (maybe it's $HOME/.mozilla/firefox/ in Linux)
FFFolder=$HOME/Library/Application\ Support/Firefox/Profiles
# Prefs file (maybe it's user.js)
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

usage() {
    cat <<EOF

${ANSI_GREEN}$(basename "$0")${ANSI_RESET} by Jordi Roca

Remove duplicate lines from Firefox prefs.js files.
Used after using ${ANSI_CYAN}disable-private-attribution-in-firefox-profiles.sh${ANSI_RESET} script several times.

This script has only been tested for Firefox v129.0 in macOS in August 2024

EOF

}

usage

# check it's darwin
if [ "$(uname -s)" != "Darwin" ]; then
    echo "${ANSI_RED}ERROR:${ANSI_RESET} This script is only for macOS"
    echo "Please, adapt the script to your system it in other systems"
    echo
    exit 1
fi

read -p "Do you want to proceed? (y/n) " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo
    echo "${ANSI_YELLOW}Hasta luego, Lucas!${ANSI_RESET}"
    echo
    exit 1
fi

echo
for FILE in "${FFFolder}"/*/"${PREFSFILENAME}"; do
    if [ ! -f "$FILE" ]; then
        echo "${ANSI_RED}ERROR:${ANSI_RESET} File not found ${ANSI_CYAN}$FILE${ANSI_RESET}"
        continue
    fi

    TEMP_FILE=$(mktemp)

    # Invertir, eliminar duplicadas al principio y desinvertir
    tac "$FILE" | awk '!seen[$0]++' | tac >"$TEMP_FILE"

    if $(diff "$FILE" "$TEMP_FILE" >/dev/null); then
        rm -f "$TEMP_FILE"
    else
        mv "$TEMP_FILE" "$FILE"
        echo "Cleaned: ${ANSI_CYAN}$FILE${ANSI_RESET}"
    fi

done

echo
echo "Duplicate lines at the end of the files have been removed."
echo
