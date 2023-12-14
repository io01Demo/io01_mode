import sys
from scapy.all import sniff, wrpcap


# Check if the correct number of arguments are provided
if len(sys.argv) < 3 or len(sys.argv) > 4:
    print("Usage: python sniffer.py <network_interface> <output_pcap_file> [number_of_packets]")
    sys.exit(1)


network_interface = sys.argv[1]
output_pcap_file = sys.argv[2]


# Default number of packets to capture
num_packets = int(sys.argv[3]) if len(sys.argv) == 4 else 1000


# Sniff traffic on the specified network interface and write it to a pcap file
def packet_handler(packet):
    wrpcap(output_pcap_file, packet, append=True)


sniff(iface=network_interface, prn=packet_handler, count=num_packets)
