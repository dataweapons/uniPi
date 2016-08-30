***PREREQUISITES***

==============
[0] Parts list
==============

    - UNIFI Access Point(s) (UAP).
    - raspberry Pi B (RPI).
    - CAT5e or better cabling.
    - managed switches.
    - routable subnets for trusted and untrusted networks.
    - bridged wireless infrastructure over physical, managed switch ports.


==================
[1] STANDARD MODEL
==================

    - Provisioned Network Zones (PNZ) - Public/Untrusted, Public/WAN, DMZ, and Private/Trusted at layers 1-3.
      * SMB class switches (i.e: Cisco SB 24 port managed switch),
      * enterprise class firewalls and routers (i.e: sonicwall devices, Cisco ASA).
      * enterprise class wireless access points of same chipset, some bridging, some not.
      * provisioned via subnetting, VLANs, port security, static routing, ARP & MAC tables, firewalling.
      * virtual network overlaying a logical network overlaying a physical wired/wireless network.
      * layer 1 segregation of medical devices, and PHI.

    - Active Directory Domain Services (ADDS):
      * Domain functional Windows 2008 or better
      * ADDS integrated DHCP supporting secure dynamic updates
      * ADDS integrated DNS with primary forward and reverse zones for PNZ's.
      * ADDS integrated Enterprise Active Directory Certificate Services.
      * Microsoft Network Access Protection.
      * Microsoft Remote Access Services.
      * LDAP/s.

    - support for mobile devices; rules specific to vendors to allow harmonious coexistence of varying classes of devices, but
    - battery starved, old, or otherwise shitty phones can't be allowed to connect; blacklisted once the weak signal is detected.

    - mostly everywhere, deploy a number of AP's, and if needed, bridges, extenders meshes, wds, etc.
    - everywhere that above is done, take care to avoid saturation, as in, too many AP's, or similar miscalculations.
    - the AP's in use should be AP's, not UTM, NGFW, routers, etc.  The functions of the UTM should then be done by the UTM, et al.

    - everywhere there's >1 wireless AP's whose signals meet in physical space, there's disharmony.  Best to keep them separated.
    - Strategic deployment of radios (AP's) tuned at 20Hz spread over channels 1, 6, and 11 is the path to a virtuous network.
    - such situations call for proper engineering.  The kind that involves packets, routes, ciphers, algebra, calculus, and planning.
 
===============================================
[2] Implementation and integration requirements
===============================================

    - TCP/IP Ethernet network deployment that implements:
      * IPv4 and/or IPv6 address space for dedicated WLAN subnets for each private and guest subnet/VLAN.  
      * static routing, ARP and MAC tables,
      * support for Power over Ethernet (POE),
      * iphelper or DNS/DHCP proxying,
      * Layer Two (L2) and Layer Three (L3) switching and routing infrastructure:
        + VLAN topology,
        + port security,
        + rules based network seperation and isolation

    - IEEE 802.11b deployment that implements:
      * Data rates,
      * channels,
      * power levels

    - IEEE 802.1x deployment that implements:
      * Extensible Authentication Protocol-Transport Layer Security (EAP-TLS) [a]
      * AAA and Remote Authentication Dial-In User Service (RADIUS),
      * Advanced Encryption Standard (AES) and/or TKIP

    - DHCP deployment that implements [b]:
      * seperate, dedicated DHCP scopes for each private and guest WLAN subnet/VLAN,
      * BOOTP vendor extensions and DHCP options 43, 60, 82, and 138 [c],
      * DHCP user-class option for 'IPConnectionMetric' [d],
      * DHCP search options 015, 119,
      * DHCP scope options:
        + max-lease-time
        + subnet-mask
        + broadcast-address
        + routers
        + domain-name-servers
        + domain-name

    - Wireless Access Point (WAP) deployment that implements:
      * CAPWAP standards [e],
      * Lightweight AP Registration (LAP) [f],
      * condition based isolation of client connections,
      * http redirects to front-facing 'guest portal',

    - DNS deployment that implements:
      * seperate, dedicated forward and reverse zones for each private and guest WLAN subnet/VLAN,
      * client-side dynamic updates for WLAN forward and reverse zones,
      * static host records that resolve to 'unifi',
      * DNSSEC security extensions.

    - domain deployment that implements:
      * Network Access Controls (NAC) authorization and quarantining [g],
      * authentication and authorization services,
      * role-based access to networked resources,
      * directory services (i.e: Active Directory, LDAP) based lookups,
      * network-based logging and auditing integrating network and host accesses,
      * accurate time-keeping.

    - PKI deployment that implements:
      * TLS 1.2,
      * Certificate Authority,
      * certificate Revocation Lists (CRL),
      * Network Device Auto-Enrollment,
      * OCSP



=============
[3] FOOTNOTES
=============

[a] RFC 2716 - PPP EAP TLS Authentication Protocol: https://www.ietf.org/rfc/rfc2716.txt

[b] RFC 2131 - Dynamic Host Control Protocol: https://www.ietf.org/rfc/rfc2131.txt

[c] RFC 2132 - DHCP Options and BOOTP Vendor Extensions: https://tools.ietf.org/html/rfc2132

[d] Microsoft DNS specific: https://msdn.microsoft.com/en-us/library/windows/desktop/aa394217(v=vs.85).aspx

[e] RFC 5415 - Control And Provisioning of Wireless Access Points (CAPWAP) Protocol Spec.: https://tools.ietf.org/rfc/rfc5415.txt

[f] http://www.cisco.com/c/en/us/support/docs/wireless-mobility/wireless-lan-wlan/70333-lap-registration.html

[g] such as Cisco Clean Access, Microsoft Network Access Protection, and others

