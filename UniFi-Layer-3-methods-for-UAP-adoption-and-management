*** https://help.ubnt.com/hc/en-us/articles/204909754-UniFi-Layer-3-methods-for-UAP-adoption-and-management ***

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
INITIAL SETUP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Please make sure you're familiar with how UniFi works (e.g. where AP and Controller is in the same L2) 
before you attempting L3 Management. L3 management adds many moving parts in the mix (i.e. added complexity).

UniFi AP has a default inform URL http://unifi:8080/inform. Thus, the purpose of using DHCP option 43 or DNS
is to allow the AP to know the IP of the controller.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DNS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
You'll need to configure your DNS server to resolve 'unifi' to your controller's IP address. 
Make sure that AP can resolve controller's domain name. For example, if you are setting 
http://XYZ:8080/inform, then ping from AP to determine if XYZ is resolvable/reachable.

Or, using FQDN for the controller inform URL, http://FQDN:8080/inform

Troubleshooting - AP (with static IP) fails to connect to the L3 controller
when configured an AP from DHCP to static in the controller UI, make sure you 
have put the IP of DNS. If not, then the AP cannot contact DNS to resolve controller domain name.

if the AP has been reset (by pushing reset button), make sure that you have informed AP twice 
(using discovery utility) about the controller's location (this will be improved in the coming release 2.3.0)
