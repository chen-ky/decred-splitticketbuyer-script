#!/bin/bash

#    dcr-splittickerbuyer-script: A bash script to buy split ticket interactively.
#    Copyright (C) 2021  Chen Kang Yang
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

echo '   dcr-splittickerbuyer-script  Copyright (C) 2021  Chen Kang Yang'
echo '   This program comes with ABSOLUTELY NO WARRANTY.'
echo '   This is free software, and you are welcome to redistribute it under'
echo '   certain conditions.'
echo '   See https://www.gnu.org/licenses/gpl.html for more information.'
echo

# Check splitticketbuyer exist in current directory
if ! [ -f "splitticketbuyer" ]
then
	echo 'Please place and execute this script in the same directory as the splitticketbuyer binary.'
	echo 'The splitticketbuyer binary can be obtained here:'
	echo 'https://github.com/matheusd/dcr-split-ticket-matcher/releases'
	exit 1
fi

# Check configuration file for splittickebuyer exist
if ! [ -f ~/.splitticketbuyer/splitticketbuyer.conf ]
then
	echo 'Setting up configuration file on first run.'
	echo
	./splitticketbuyer
	EXITCODE=$?
	echo
	echo 'Please make changes to the configuration file before proceeding.'
	echo 'Configuration file path: '~/.splitticketbuyer/splitticketbuyer.conf

	exit $EXITCODE
fi

# Get required information
ORIGINAL_IFS="$IFS"
IFS=""
echo -n "Enter wallet password: "
read -r -s PASSWORD
echo
IFS="$ORIGINAL_IFS"

echo -n "Enter maximum purchase amount (DCR): "
read AMOUNT

echo -n "Session name: "
read SESSION

# Execute splitticketbuyer
while :
do
	echo
    OUTPUT=$(./splitticketbuyer --sessionname="$SESSION" --maxamount="$AMOUNT" "$@" <<< "$PASSWORD" 2>&1 | tee /dev/tty)
	echo -n "$OUTPUT" | grep -i 'Error' &> /dev/null
    
    if [ $? ]
    then
		# Retry after 30 seconds if failed
		echo 'Retrying in 30 seconds.'
		sleep 30
	else
		break
	fi

done

echo 
echo 'If you like what I am doing, please consider giving me a donation.'
echo 'DCR: DsXpofPmgwZGTncpsEzZACkKFeqoRzYjgWv'
