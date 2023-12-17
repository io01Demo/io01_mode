import json
import xmltodict
import sys
import argparse


#Create argument parser
parser = argparse.ArgumentParser(description='XML2JSON')
 
#Add arguments
parser.add_argument('XMLinputFile', type=str, help='XML input file')
parser.add_argument('JSONoutputFile', type=str, help='name of output JSON file')
 
#Parse arguments
args = parser.parse_args()
 
#Access command-line arguments
inputXML = args.XMLinputFile
jsonFile = args.JSONoutputFile


f = open(inputXML)
xml_content = f.read()
f.close()

json_content = (json.dumps(xmltodict.parse(xml_content), indent=4, sort_keys=True))
f = open(jsonFile, "w")
f.write (json_content)
f.close()
print (json_content)