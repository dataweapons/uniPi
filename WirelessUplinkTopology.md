*** https://help.ubnt.com/hc/en-us/articles/205146000-UniFi-Set-up-UAPs-in-wireless-uplink-topology ***

<UniFi - Set up UAPs in wireless uplink topology>


Switch --------(wire)--------- Uplink AP )))))))wireless(((((( Island AP

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"The wireless uplink is designed to be reliable rather than quick/dynamic. 
Please be patient for the isolated state change, the discovery, and the link setup. 
To enable wireless uplink:

   (1) Adopt all APs through wire first (using Ethernet cable). 
       In other words, adopt both uplink and island APs.

   (2) Put the island AP to the intended location and connect its power. 
       This means connect power adapter POE port to the island AP, but 
       leave power adapter LAN port empty.

   (3) After the island AP is up, on the controller, wait until it becomes 
       "Heartbeat Missed" and then "Disconnected" or "Isolated" state 
       (takes about6+ minutes). It will _not_ service any configured WLANs at this moment.

   (4) Go to AP dialog->Configure->Wireless Uplink, select the uplink AP of your choice
       (click on "Find more" if no uplink AP is shown) The controller establishes wireless 
       uplink between the selected uplink AP and the island AP. The island AP is now wireless 
       connected and serving."

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Wireless Uplink introduces a new status: "Isolated". When the AP is unable to reach the gateway, 
it goes into the Isolated state. In this state:

     (1) All servicing WLANs are disabled (if we cannot reach the gateway, wireless clients won't either)

     (2) Has different LED pattern - steady green (managed) with occasional dims

     (3) AP will send out beacon over the air and can be found by nearby APs

     (4) Only the wired APs under the same controller can establish a downlink to this isolated AP

     (5) By default, wired APs don't go off-channel to look for isolated APs. "Find more" trigger wired 
         APs to do so. And after wireless uplink is set up, the isolated AP will always find and follow 
         the same channel use by its uplink AP

