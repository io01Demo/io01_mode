#!/bin/bash

# Set variables
base_url="https://services.nvd.nist.gov/rest/json/cves/2.0?"
vendor="$1"
product="$2"
filename="$3"
api_key="b9eca5af-dac0-473b-9405-29b96a4976cd"

# Validate parameters
if [[ -z "$vendor" || -z "$product" ]]; then
  echo "Error: Missing required parameters. Usage: $0 <vendor> <product> <outputfile>"
  exit 1
fi

# Build CPE string
cpe_string="cpeName=cpe:2.3:o:$vendor:$product"
#encoded_cpe_string=$(echo "$cpe_string" | urlencode)

# Build query URL and headers
#query_url= "https://services.nvd.nist.gov/rest/json/cves/2.0?cpeName=cpe:2.3:o:microsoft:windows_10:1607"

keywordSearch_url="keywordSearch=$vendor"
#query_url=$base_url$cpe_string    #seach based on CPE and product
query_url="$base_url$keywordSearch_url"   # search based on keywords 

# https://services.nvd.nist.gov/rest/json/cves/2.0?keywordSearch=Siemens

headers="-H \"apiKey: $api_key\""


# Make API call using curl

curl $query_url -o $filename
#cves=$(curl -sSL "$query_url" $headers)
#cves=$(curl -sSL "$query_url" )
cat $filename | jq ".vulnerabilities "
cat $filename | jq  ".vulnerabilities " > "CVE" + $filename #JSON format
#rm $filename
echo "Relavant CVE's"
echo "---------------------------"
cat "CVE" + $filemame |grep "CVE" 
msg="Query- $query_url"
echo $msg
echo "For detailed information about each CVE, please visit the NVD website: https://nvd.nist.gov/vuln/detail Or contact IO01 team"

exit 0
