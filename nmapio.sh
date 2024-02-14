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
sudo nmap -Pn -sT --scan-delay 1s -p 80,102,443,502,530,593,789,1089-1091,1911,1962,2222,2404,4000,4840,4843,4911,9600,19999,20000,20547,34962-34964,34980,44818,46823,46824,55000-55003 -oX $filename $ip
#sudo nmap -sn -oX $filename $ip
echo "[+] converting to JSON"

python3 nmappy.py $filename tmpJS.json
cat tmpJS.json
#rm tmpJS.json
#cat $filename
#rm $filename
echo "[*] Done. "


#.nmaprun.host
#.nmaprun.host.address
#.nmaprun.host.hostnames
#.nmaprun.host.ports
#.nmaprun.host[].address."@addr"

#echo "Relavant CVE's"
#echo "---------------------------"
#cat tmpJS.json | jq '.vulnerabilities[].cve | [.id, .descriptions[].value, .published]'
#echo "For detailed information about each CVE, please visit the NVD website: https://nvd.nist.gov/vuln/detail Or contact IO01 team"

exit 0
