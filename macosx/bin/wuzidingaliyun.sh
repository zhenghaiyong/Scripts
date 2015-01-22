#!/usr/bin/expect
spawn ssh zhenghaiyong@58.96.185.229
expect "zhenghaiyong@58.96.185.229's password: "
send "password\r"
interact
