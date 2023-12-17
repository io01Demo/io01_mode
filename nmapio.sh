#!/bin/bash

# Set variables

ip="$1"
filename="tmpNmapOutput.tmp"

# Validate parameters
if [[ -z "$ip" ]]; then
  echo "Error: Missing required parameters. Usage: $0 <IP> <output file>"
  exit 1
fi

echo "[+] executing OT port scanning "
sudo nmap -sn -oX $filename $ip
echo "[+] converting to JSON"

python3 nmappy.py $filename tmpJS.json
cat tmpJS.json
#rm tmpJS.json
#cat $filename
#rm $filename
echo "[*] Done. "


#cves=$(curl -sSL "$query_url" $headers)
#cves=$(curl -sSL "$query_url" )

#.vulnerabilities[].cve
#.vulnerabilities[].cve.id
#.vulnerabilities[].cve.descriptions[].value
#.vulnerabilities[].cve.published
#.vulnerabilities[].cve | [.id, .descriptions[].value, .published]
#.vulnerabilities[].cve | [.id, .descriptions[].value, .published] | @csv

#echo "Relavant CVE's"
#echo "---------------------------"
#cat $filename | jq '.vulnerabilities[].cve | [.id, .descriptions[].value, .published]'
#CVEfile="CVE"$filename
#cat $filename | jq  '.vulnerabilities[].cve | [.id, .descriptions[].value, .published] | @csv' > $CVEfile #JSON format

#msg="Query- $query_url"
#echo $msg
#echo "For detailed information about each CVE, please visit the NVD website: https://nvd.nist.gov/vuln/detail Or contact IO01 team"

exit 0