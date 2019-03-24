#!/bin/sh
sudo apt-get install nmap -y 
sudo nmap -sP $1 >> online_hosts.txt
sudo apt-get remove nmap -y 
