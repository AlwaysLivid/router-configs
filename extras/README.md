# Router Configurations (extras)

This directory contains some of the highly personalized scripts that I use or have used on my own machines, in order to prepare an isolated subnet with my own personal appliances. There are many different tools for handling the problems that the contents of this folder aim to solve.

These scripts have been tested in an [Arch Linux ARM](https://archlinuxarm.org/) system and a variation of them is currently being used on my own system. Nevertheless, they were published for educational purposes, because I believe that they are able to sufficiently help other people that are very likely to get stuck on the same issues that I did.

Please consider the following;

- **The scripts are *NOT* meant to be used in production systems and will not work without any modifications.**
- **Make sure to change the interface names and the subnet masks depending on your situation.**
- **The [prepare_server](extras/prepare_server.sh) script stores the `iptables` configurations in a way that's specific to Arch Linux-based distros.**

## Network topology

In order to make the purpose of the scripts clearer, I'll include a quick demonstration of how my network approximately looks like.

```
|================|                |------------------------------------|                      |------------|
|     Router     |                |         Raspberry Pi 4B+           |                      |            |
|                | ------> (eth0) >                                    > (enp1s0u1u2) ------> | Appliances |
| 192.168.1.1/24 |                |   192.168.1.42, 192.168.42.1/24    |  (5 ports)           |            |
|================|                ||----------------------------------||                      |------------|
                                   | dn42: 172.20.34.161 AS4242420799 |
                                   |----------------------------------|
```

In short;

* **eth0** stands for the interface that connects the main router and the Raspberry Pi

* **enp1s0u1u2** is the name of the adapter that connects the Raspberry Pi with my appliances (with an additional network switch).

* **[dn42](https://dn42.dev)** is a mesh network with access to a few interesting services that aren't available to the public internet.

## DHCP Configuration Changes

By using the [prepare_client](extras/prepare_client.sh) script, you'd have to manually modify the script everytime on every client.

It would be likely preferrable for you to find another means of setting a static IP address on your system.

Alternatively, you can add the following lines in [dnsmasq.conf](etc/dnsmasq.conf) in order to have your router assign IP addresses to your appliances automatically.

```
## sets range of ip addresses that can be assigned
dhcp-range=enp1s0u1u2,192.168.42.10,192.168.42.20,24h

## sets network gateway
dhcp-option=enp1s0u1u2,3,192.168.42.1
```

**These two lines aren't included in [dnsmasq.conf](etc/dnsmasq.conf) by default. Make sure to add them and make any appropriate changes.**

### Credits

Special thanks to the following people that took the time to assist me (in no particular order);

- [Kioubit](https://dn42.g-load.eu)
- [Matthias Merkel](https://github.com/Moritz30)
- [burble](https://dn42.burble.com/)
- [tomty89](https://github.com/tomty89)
- [tds](https://github.com/tds)

Additionally, I came across the following resources that were particularly useful to me;

- [Arch Linux Wiki](https://wiki.archlinux.org/)
- [Frank Wiles](https://www.revsys.com/writings/quicktips/nat.html)
