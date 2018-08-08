#!/usr/bin/expect -f
set ip [lindex $argv 0 ]
set password [lindex $argv 1 ]
set timeout 30

spawn ssh root@$ip
expect {
"*yes/no" { send "yes\r"; exp_continue}
"*password:" { send "$password\r";exp_continue }
}

expect "#*"  
send "/usr/local/bin/redis-cli slaveof 172.27.9.31 6379\r"  
send  "exit\r"  
expect eof  
