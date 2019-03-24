#!/bin/sh
yum install nmap -y -qq
nmap -sP $1 >> online_hosts.txt

#| grep 192. | awk '{print $NF}' >> online_hosts.txt
yum remove nmap -y -qq
