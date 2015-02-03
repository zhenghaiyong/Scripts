#!/usr/bin/expect
spawn ssh zhenghaiyong@miscread.com
expect "zhenghaiyong@miscread.com's password: "
send "password\r"
interact
