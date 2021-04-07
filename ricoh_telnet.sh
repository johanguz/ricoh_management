#!/bin/bash
#Script to telnet to Ricoh Copiers and Change Settings using the expect command
# this one sets the sntp server
#csv in /tmp folder can contain copier credentials to be tee'd into script
#Written by Johan Guzman 

IFS=,

while true
	read hostName user credential
do
	/usr/bin/tee /tmp/ricoh_sntp.sh << telnetScript
	#!/usr/bin/expect
	set timeout 20
	
	spawn telnet $hostName
	
	expect "RICOH Maintenance Shell."
	expect "login:"
	send "${user}\r"
	expect "Password:"
	send "${credential}\r"
	send "sntp server \"time.apple.com\"\r"
	send "logout\r"
	expect "Do you save configuration data? (yes/no/return)"
	send "yes\r";
telnetScript
	chmod 755 /tmp/ricoh_sntp.sh
	/usr/bin/expect /tmp/ricoh_sntp.sh
	
done < /tmp/ricohIP.csv