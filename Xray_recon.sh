#!/data/data/com.termux/files/usr/bin/bash

# Colors
green='\033[1;32m'
red='\033[1;31m'
blue='\033[1;34m'
reset='\033[0m'

# Logo
echo -e "${blue}
╔═╗╔═╗╦═╗╔═╗╦═╗ ╔═╗╔═╗╔═╗╔═╗╦═╗╔═╗
╚═╗║╣ ╠╦╝║╣ ╠╦╝ ║ ║ ║╠╣ ╠╩╗╚═╗
╚═╝╕╝╩╚═╝╩╚═╝╩╚═ ╚═╝� ╩ ╩╩╚═╝ v1.0
${reset}"

# Checking requirements
for pkg in curl net-tools; do
if ! command -v $pkg > /dev/null;  then
echo -e "${red}[!] $pkg needs to be installed... installing${reset}"
pkg install -y $pkg > /dev/null
fi
done
# Public IP and location
echo -e "${green}[+] IP and location:${reset}"
curl -s ipinfo.io
echo
# System information
echo -e "${green}[+] System information:${reset}"
uname -a
echo
# Active users
echo -e "${green}[+] System users:${reset}"
who || echo "who is not available"
echo
# Network information
echo -e "${green}[+] Network information:${reset}"
ifconfig
echo
# Gateway and DNS
echo -e "${green}[+] Gateway and DNS:${reset}"
ip route |  grep default
cat /etc/resolv.conf
echo

# Simple port scan (as ping)
echo -e "${green}[+] Port scan first 5 ports 127.0.0.1:${reset}"
for port in 21 22 23 80 443; do
(echo > /dev/tcp/127.0.0.1/$port) >/dev/null 2>&1 && \
echo "Port $port is OPEN" ||  echo "Port $port is closed"
done
echo

# Save to file
echo -e "${green}[+] Save output to file: xray_output.txt${reset}"
{
echo "### IP Info ###"
curl -s ipinfo.io
echo
echo "### System Info ###"
uname -a
echo
echo "### Users ###"
who
echo
echo "### Network ###"
ifconfig
echo
echo "### Route ###"
ip route
echo
echo "### DNS ###"
cat /etc/resolv.conf
} > xray_output.txt

echo -e "${blue}[*] Done! Output file: xray_output.txt${reset}"
