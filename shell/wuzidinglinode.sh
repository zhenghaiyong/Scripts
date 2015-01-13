#!/usr/bin/expect
spawn ssh zhenghaiyong@104.237.153.139
expect "zhenghaiyong@104.237.153.139's password: "
send "flyzhyggwuziding\r"
interact
