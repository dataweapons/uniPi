cd <unifi_base>
# on Windows, "%USERPROFILE%/Ubiquiti Unifi" cd /usr/lib/unifi
# create new certificate (with csr) java -jar lib/ace.jar new_cert <hostname> <company> <city> <state> <country>
# your CSR can be found at /var/lib/unifi
# - unifi_certificate.csr.der # - unifi_certificate.csr.pem
# have this CSR signed by a CA, you'll get a few certificates back...
# copy the signed certificate(s) to <unifi_base> # import the signed certificate and other intermediate certificates java -jar lib/ace.jar import_cert <signed_cert> [<other_intermediate_root_certs>...]


Use certtool to generate my own CA
Import this CA into the JRE security CA as a trusted CA
Modify server.xml adding two key lines modifying the SSL handler to accept a "modern" cert
Generate a CSR using ace.jar new_cert
Sign the new cert with my own CA (self signed (no CA) I was never able to get to work). Ensure using PKCS12 or things gets very odd
Import the signed cert using the command in the "documentation" adding the CA key to the command
Going to http://unifi:8080 - or rather https://unifi:8443 to initiate the portal. If you try to go directly to the portal (:8880) you get a faulty redirect, and if you manually try https://unifi:8843 you get bad URL errors (missing parameters etc) until you've done the initaliztion through :8843).


Re: UniFi controller vmware appliance 3.2.1
Options
‎01-12-2015 08:34 AM

Went through the process to get Cert from Enterprise CA installed.  Thought I would update the instructions here for this very helpful VM.  Main issues were:  path to Unifi was wrong, had to add path to java to get it to work, and CSR was saved under "data" subdirectory, rather than Unifi Base path.
 
 
sudo su -
# cd <unifi_base>
# For VM: cd /var/unifi/UniFi
# create new certificate (with csr) java -jar lib/ace.jar new_cert <hostname> <company> <city> <state> <country>
I had to add a path to "java".  So I ran:
/usr/local/jre-1.7.0/bin/java -jar lib/ace.jar new_cert <hostname> <company> <city> <state> <country>
On additional issue I ran into was our company name has a space in it, so I had to add quotes around <company>
# your CSR can be found at /var/unifi/UniFi/data
# - unifi_certificate.csr.der # - unifi_certificate.csr.pem
# have this CSR signed by a CA, you'll get a few certificates back...
# copy the signed certificate(s) to <unifi_base> # import the signed certificate and other intermediate certificates java -jar lib/ace.jar import_cert <signed_cert> [<other_intermediate_root_certs>...]
Again I had to add the path to the front of java to get it to run.
 
With this, it worked flawlessly, using a MS Windows CA.
