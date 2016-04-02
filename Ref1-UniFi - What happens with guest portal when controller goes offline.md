UniFi - What happens with guest portal when controller goes offline?
August 22, 2015 13:02
Overview

When an AP cannot reach the controller, it goes into a so-called SELFRUN state.

In this state, it doesn't make sense to redirect the guests to the portal (controller) which is not reachable, AP will automatically allow the guest to use the network without redirecting. Moreover,

the guest access policies are still effective (L2/L3 isolation) along with the restricted subnets feature
the user group (bandwidth limiting, etc) associated with this WLAN is still effective
when the controller comes back online (and AP goes into MANAGED state), the guest portal redirection will restore automatically
Starting from 2.3.9+, you'll be able to add/modify <unifi_base>/data/config.properties

Starting in v3, config.properties file needs to be placed under
<unifi_base>/data/sites/<site id>/ directory because config properties are site related.
 
Therefore, in v3, the directory to hold config.properties file is different than v2.
 
After adding/modifying the config.properties file, trigger a re-provision to all APs (NOT restart). For example, toggle on/off the uplink monitor checkbox, etc.
 
To check whether the configuration has been taken in by AP, SSH into the AP, execute 'cat cfg/mgmt',
you should see 'mgmt.selfrun_guest_mode=off' in the output.
 
 
# config.selfrun_guest_mode=pass # when controller is offline, automatically 
                                 # authorize all guests (all guest isolation 
                                 # / policy is still enforced)

# config.selfrun_guest_mode=off  # to disable all the guest SSIDs when controller
                                 # is not reachable. Note that "guest portal" must
                                 # be being used otherwise controller will NOT disable
                                 # guest SSIDs.
 
Note:
When choosing a line to enter into the config.properties file, do NOT enter any comments before or after. So for example, to disable guest SSID when in SELFRUN mode the line in config.properties would look like the following:
 

config.selfrun_guest_mode=off
