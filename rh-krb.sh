# Script to kerberize Fedora Laptop for RH
# KCS 30th Jan 2015
# Not sure if can run this as a script as instructions say paste commands into *same* root terminal
# https://mojo.redhat.com/docs/DOC-931465

yum -y install sssd krb5-workstation

Lcorp=ldap.corp.redhat.com
L1rdu=ldap01.intranet.prod.int.rdu2.redhat.com
L2rdu=ldap02.intranet.prod.int.rdu2.redhat.com
K1rdu=kerberos01.core.prod.int.rdu2.redhat.com
K2rdu=kerberos02.core.prod.int.rdu2.redhat.com
K1phx=kerberos01.core.prod.int.phx2.redhat.com
L1ams=ldap01.intranet.prod.int.ams2.redhat.com
L2ams=ldap02.intranet.prod.int.ams2.redhat.com
K1ams=kerberos01.core.prod.int.ams2.redhat.com
K2ams=kerberos02.core.prod.int.ams2.redhat.com
L1sin=ldap01.intranet.prod.int.sin2.redhat.com
L2sin=ldap02.intranet.prod.int.sin2.redhat.com
K1sin=kerberos01.core.prod.int.sin2.redhat.com
K2sin=kerberos02.core.prod.int.sin2.redhat.com

# E. USA:
# regionSpecificOptions="--ldapserver=${L1rdu},${L2rdu},${Lcorp} --krb5kdc=${K1rdu},${K2rdu},${K1phx}"

# W. USA:
# onSpecificOptions="--ldapserver=${L1ams},${L2ams},${Lcorp} --krb5kdc=${K1ams},${K2ams},${K1phx}"regionSpecificOptions="--ldapserver=${Lcorp},${L1rdu},${L2rdu} --krb5kdc=${K1phx},${K1rdu},${K2rdu}"

#EMEA:
regionSpecificOptions="--ldapserver=${L1ams},${L2ams},${Lcorp} --krb5kdc=${K1ams},${K2ams},${K1phx}"

#APAC:
# regionSpecificOptions="--ldapserver=${L1sin},${L2sin},${Lcorp} --krb5kdc=${K1sin},${K2sin},${K1phx}"

authconfig ${regionSpecificOptions} --enablesssd --enablesssdauth --enableldap --ldapbasedn=dc=redhat,dc=com --enableldaptls --ldaploadcacert=http://password.corp.redhat.com/cacert.crt --enablekrb5 --krb5adminserver=kerberos.corp.redhat.com --krb5realm=REDHAT.COM --enablecachecreds --enablelocauthorize --update
