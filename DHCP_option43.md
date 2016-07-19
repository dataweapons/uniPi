Linux's ISC DHCP server: dhcpd.conf

# ...
option space ubnt;
option ubnt.unifi-address code 1 = ip-address;

class "ubnt" {
        match if substring (option vendor-class-identifier, 0, 4) = "ubnt";
        option vendor-class-identifier "ubnt";
        vendor-option-space ubnt;
}

subnet 10.10.10.0 netmask 255.255.255.0 {
        range 10.10.10.100 10.10.10.160;
        option ubnt.unifi-address 201.10.7.31;  ### UniFi Controller IP ###
        option routers 10.10.10.2;
        option broadcast-address 10.10.10.255;
        option domain-name-servers 168.95.1.1, 8.8.8.8;
        # ...
}
Cisco CLI

# assuming your UniFi is at 192.168.3.10
ip dhcp pool <pool name>
network <ip network> <netmask>
default-router <default-router IP address>
dns-server <dns server IP address>
option 43 hex 0104C0A8030A # 192.168.3.10 -> CO A8 03 0A

# Why 0104C0A8030A ?
#
# 01: suboption
# 04: length of the payload (must be 4)
# C0A8030A: 192.168.3.10
Mikrotik CLI

/ip dhcp-server option add code=43 name=unifi value=0x0104C0A8030A
/ip dhcp-server network set 0 dhcp-option=unifi

# Why 0104C0A8030A ?
#
# 01: suboption
# 04: length of the payload (must be 4)
# C0A8030A: 192.168.3.10
Cisco has a good write-up for DHCP option 43 setup.

To use IP of controller

You can also use the IP of the controller in the inform URL instead of the domain name.
SSH

If you can SSH into the AP, it's possible to do L3-adoption via CLI command:

# 1. make sure the AP is running the same firmware as the controller. If it is not, see this guide: Upgrading UniFi firmware via SSH.
# 2. make sure the AP is in factory default state
#    if it's not, do
#    syswrapper.sh restore-default
# 3. ssh into the device and type mca-cli
# the CLI interface:
set-inform http://ip-of-controller:8080/inform
