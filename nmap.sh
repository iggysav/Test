#!/bin/sh
apt-get install nmap -y -qq
nmap -sP $1 >> online_hosts.txt

#| grep 192. | awk '{print $NF}' >> online_hosts.txt
apt-get remove nmap -y -qq
