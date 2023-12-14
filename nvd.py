import requests

# Base URL for NVD CVE API
base_url = "https://services.nvd.nist.gov/rest/json/cves/2.0"



# Define vendor, product, and API key
vendor = "Microsoft"
product = "Windows Server"
api_key = " b9eca5af-dac0-473b-9405-29b96a4976cd"

# Build CPE string based on vendor and product
cpe_string = f"cpe:2.3:part:{vendor}:product:{product}:*"

# Encode the CPE string
encoded_cpe_string = requests.utils.quote(cpe_string)

# Build query parameters including the API key
params = {
    "cpeMatchString": encoded_cpe_string,
    "apiKey": api_key
}

try:
    # Send GET request with headers including the API key
   


    response = requests.get("https://services.nvd.nist.gov/rest/json/cves/2.0?cpeName=cpe:2.3:o:microsoft:windows_10:1607 ")
   #response = requests.get(f"{base_url}", params=params, headers={"Authorization": f"Bearer {api_key}"})
    data = response.json()
    print(data)
    # Check for successful response and process data
    if response.status_code == 200:
        print ("200 OK")
        cves = data["cves"]
        ... # Process and display results

    else:
        print(f"Error: {response.status_code}")
        print(f"Reason: {response.reason}")

except Exception as e:
    print(f"Error: {e}")