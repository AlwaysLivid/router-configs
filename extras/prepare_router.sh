# ======
# Notes:
# ======
# My Raspberry Pi has two interfaces; the ordinary Ethernet port that ships with it, and an additional
# TP-Link UE300 USB-to-Ethernet adapter, which is connected to a 5-port TP-Link switch.

# assigns address to interface
ip a a 172.20.34.161 dev eth1

# iptables configurations

## IPv4/IPv6 NAT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
iptables -A FORWARD  -o eth0 -j DROP

ip6tables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
ip6tables -A FORWARD -i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT
ip6tables -A FORWARD -i eth1 -o eth0 -j ACCEPT
ip6tables -A FORWARD  -o eth0 -j DROP

## dn42
### Replace the subnet and the IP of your router accordingly.
### This exposes the dn42 network to the "appliances".

iptables -t nat -A POSTROUTING -s 192.168.42.1/24 -j SNAT --to 172.20.34.161

## makes changes permanent by saving them to a file
iptables-save -f /etc/iptables/iptables.rules
ip6tables-save -f /etc/iptables/ip6tables.rules

## enables systemd services, so that the changes are immediately
## applied upon booting the machine.
sudo systemctl enable --now iptables
sudo systemctl enable --now ip6tables
