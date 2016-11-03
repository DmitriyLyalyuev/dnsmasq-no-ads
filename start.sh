#!/bin/sh

mkdir -p /etc/dnsmasq.d

echo "Creating ads domains list"

wget -qO - "http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&startdate[day]=&startdate[month]=&startdate[year]=" | egrep -v "^#" | grep 127.0.0.1 | awk '{print $2}' > yoyo.txt
wget -qO - http://winhelp2002.mvps.org/hosts.txt | egrep -v "^#" | grep 0.0.0.0 | awk '{print $2}' > mvps.txt
wget -q http://malware-domains.com/files/domains.zip
unzip domains.zip
egrep -v "^#" domains.txt | awk '{print $1}'> malwaredomains.txt
rm -f domains.*
wget -qO - http://adaway.org/hosts.txt | egrep -v "^#" | grep 127.0.0.1 | awk '{print $2}'> adaway.txt
wget -qO - http://www.malwaredomainlist.com/mdlcsv.php | egrep -v "^#" | awk -F"," '{print $2}' | sed 's/"//g' | awk -F"/" '{print $1}' | awk -F":" '{print $1}' | sort -u | grep -v "-" | egrep -v "^$" > malwaredomainlist.txt
wget -qO - http://someonewhocares.org/hosts/hosts | egrep -v "^#" | grep 127.0.0.1 | awk '{print $2}' > danpollock.txt
wget -q    http://hosts-file.net/download/hosts.zip
unzip hosts.zip hosts.txt > /dev/null
cat hosts.txt | egrep -v "^#" | grep 127.0.0.1 | awk '{print $2}' > hphosts.txt
rm -f hosts.zip hosts.txt

cat *.txt | sed 's/\r$//' | tr '[:upper:]' '[:lower:]' | sed 's/\.$//g'  | sort -u | uniq | egrep -v "^$" | egrep -v "^-" | egrep -v "${WHITE_LIST}" | awk '{print "address=/"$1"/127.0.0.1"}' > /etc/adblock
rm -f *.txt

echo "Starting DNSMask..."

dnsmasq --no-resolv --keep-in-foreground --no-hosts --bind-interfaces --pid-file=/var/run/dnsmasq.pid --listen-address=0.0.0.0 --cache-size=0 --conf-file=/dev/null \
	--proxy-dnssec --conf-dir=/etc/dnsmasq.d --conf-file=/etc/adblock --server=8.8.8.8 --server=8.8.4.4
