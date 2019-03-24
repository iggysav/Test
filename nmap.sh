#!/bin/sh
sudo yum install nmap -y 
sudo nmap -sP $1 >> online_hosts.txt

#| grep 192. | awk '{print $NF}' >> online_hosts.txt
sudo yum remove nmap -y 
