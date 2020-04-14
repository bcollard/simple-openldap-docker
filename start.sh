#!/bin/sh -ex

# /etc/openldap/ <-- config
# /var/lib/openldap <-- data
# /run/openldap <-- process locks
# /usr/lib/openldap <-- modules

export PASSWD="$(slappasswd -h {SHA} -s ${PASSWORD})"
sed -i "s/^rootpw\t\tsecret/rootpw\t\t${PASSWD}/" /etc/openldap/slapd.conf

mkdir /run/openldap /var/lib/openldap/openldap-data || true

if [[ -d "/tmp/ldif" ]]; then 
    for file in `ls /tmp/ldif/*.ldif`; do
        slapadd -c -F /etc/openldap -f /etc/openldap/slapd.conf -b "dc=mycompany,dc=corp" -l "$file" || true
    done
fi

chown -R ${USER_ID}.${GROUP_ID} /etc/openldap/ /var/lib/openldap /run/openldap /usr/lib/openldap
chmod 700 /var/lib/openldap /var/lib/openldap/openldap-data

exec /usr/sbin/slapd -u ${USER_ID} -g ${GROUP_ID} -h "ldap:///" -f /etc/openldap/slapd.conf -F /etc/openldap/ -d 32
