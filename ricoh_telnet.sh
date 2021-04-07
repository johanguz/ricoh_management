#!/usr/bin/expect
#Script to telnet to Ricoh Copiers and Change Settings using the expect command
#Written by Johan Guzman 

IFS=,

while true
	read a idx
do
	/usr/bin/tee /tmp/ricoh_sntp.sh << telnetScript
	#!/usr/bin/expect
	set timeout 20
	set hostName $a
	set userName "admin"
	set password ""
	
	spawn telnet $a
	
	expect "RICOH Maintenance Shell."
	expect "login:"
	send "admin\r"
	expect "Password:"
	send "\r";
	send "sntp server \"time.apple.com\"\r"
	send "logout\r"
	expect "Do you save configuration data? (yes/no/return)"
	send "yes\r";
telnetScript
	chmod 755 /tmp/ricoh_sntp.sh
	/usr/bin/expect /tmp/ricoh_sntp.sh

done < /tmp/ricohIP.csv