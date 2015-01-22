#!/usr/bin/expect
spawn ssh zhenghaiyong@115.28.166.186
expect "zhenghaiyong@115.28.166.186's password: "
send "flyzhygghuizhi\r"
interact
