#!/usr/bin/expect
#	$scriptsDir/connect.expect $host $unixID $unixPass $appuser
#nc1-iphonesys-it-app001
#ma1-iosscsp-lapp01.apple.com
set timeout 60
set script script.sh
spawn ssh [lindex $argv 1]@[lindex $argv 0]
expect {
"(yes/no)? " { 
send "yes\r"
     expect "[*bash*" { send "sudo -u [lindex $argv 3] -i\r" 
        expect "*password*" {send "[lindex $argv 2]\r"}}}
       "*bash*" { send "sudo -u [lindex $argv 3] -i\r" 
        expect "*password*" {send "[lindex $argv 2]\r"}}}
interact
