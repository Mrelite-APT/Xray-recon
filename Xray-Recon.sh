#!/data/data/com.termux/files/usr/bin/bash

 green='\033[1;32m'
 blue='\033[1;34m'
 reset='\033[0m'

 echo -e "${blue}Xray-Recon - Powered by Mrelite-APT${reset}"
 echo

 # Prerequisites
 for pkg in curl net-tools;  do
   if  command -v $pkg > /dev/null;  then
echo -e "${green}[+] Install $pkg ...${reset}"
pkg install -y $pkg > /dev/null
fi
done
# Get target from user
read -p ">>> Please enter target IP or domain: " target

# Display IP information
echo -e "${green}[+] Get target IP and location information:${reset}"
curl -s ipinfo.io/$target
echo
# Display target DNS information
echo -e "${green}[+] Get target DNS information:${reset}"
nslookup $target
echo
# Ping target
read -p ">>> Ping? (y/n): " ping_ans
if [[ "$ping_ans" == "y" ]];  then
echo -e "${green}[+] ping $target:${reset}"
ping -c 4 $target
echo
fi

# Scan ports
read -p ">>> Do you want to perform a port scan? (y/n): " port_ans
if [[ "$port_ans" == "y" ]]; then
read -p ">>> Enter ports (e.g.: 21 22 80 443): " ports
echo -e "${green}[+] Scanning ports on $target ...${reset}"
for port in $ports; do
(echo > /dev/tcp/$target/$port) >/dev/null 2>&1 && \
echo "Port $port is open" ||  echo "Port $port is closed"
done
echo
fi

# Save output
read -p ">>> Save data to output file? (y/n): " save_ans
if [[ "$save_ans" == "y" ]]; then
outfile="xray_output.txt"
echo "[*] Save data to $outfile"
{
echo "### Target: $target ###"
echo "[IP Info]"
curl -s ipinfo.io/$target
echo
echo "[DNS Info]"
nslookup $target
echo
} > $outfile
echo -e "${blue}[✓] Output saved to file $outfile${reset}"
fi
