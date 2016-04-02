# on Windows, "%USERPROFILE%/Ubiquiti Unifi" 
cd /usr/lib/unifi
#
# create new certificate (with csr) 
java -jar lib/ace.jar new_cert <hostname> <company> <city> <state> <country>
#
# your CSR can be found at /var/lib/unifi
# - unifi_certificate.csr.der 
# - unifi_certificate.csr.pem
# have this CSR signed by a CA, you'll get a few certificates back...
# copy the signed certificate(s) to <unifi_base> 
# import the signed certificate and other intermediate certificates 
#
java -jar lib/ace.jar import_cert <signed_cert> [<other_intermediate_root_certs>...]
#
sudo su -
cd /var/unifi/UniFi
#
# create new certificate (with csr) 
/usr/local/jre-1.7.0/bin/java -jar lib/ace.jar new_cert <hostname> <company> <city> <state> <country>
#
# your CSR can be found at /var/unifi/UniFi/data
# - unifi_certificate.csr.der 
# - unifi_certificate.csr.pem
# have this CSR signed by a CA, you'll get a few certificates back...
# copy the signed certificate(s) to <unifi_base> 
#
# import the signed certificate and other intermediate certificates 
java -jar lib/ace.jar import_cert <signed_cert> [<other_intermediate_root_certs>...]
