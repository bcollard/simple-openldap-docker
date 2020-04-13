export container_volume_name=openldap-standalone
export PASS=adminlocal
export registry=pileenretard
export image_name=openldap
export image_tag=v20.04.11

build:
	docker build -t ${registry}/${image_name}:${image_tag} .

run:
	docker volume create ${container_volume_name}
	docker run -d --name ${container_volume_name} -e PASSWORD=${PASS} -p 389:389 -v ${NAME}:/var/lib/openldap ${registry}/${image_name}:${image_tag}

logs:
	docker logs ${container_volume_name}

rm: stop
	docker rm ${container_volume_name}

stop:
	docker stop ${container_volume_name}

push:
	docker push ${registry}/${image_name}:${image_tag}

exec:
	docker exec -ti ${container_volume_name} /bin/sh

# brew install openldap (kegonly)
# /usr/local/opt/openldap/bin/ldapwhoami -D "cn=admin,dc=mycompany,dc=corp" -w toto -h 127.0.0.1 -p 389 -d 32

# ldapadd -x -D "cn=admin,dc=mycompany,dc=corp" -W -f ldif/base.ldif
# ldapwhoami -D "cn=admin,dc=mycompany,dc=corp" -w rj2hue_m9OEPI3idor -h 127.0.0.1 -p 389 -d 32
# ldapsearch -x -W -D "cn=admin,dc=mycompany,dc=corp" -b "dc=mycompany,dc=corp" -LLL 'cn=admin' userPassword cn
# ldapsearch -x -W -D "cn=admin,dc=mycompany,dc=corp" -b "dc=mycompany,dc=corp" -LLL "mail=john.doe@mycompany.com" memberOf
# slapcat -f /etc/openldap/slapd.conf > /var/backups/${DATE}-startup-data.ldif
# ldapmodify -x -D "cn=admin,dc=mycompany,dc=corp" -W << EOF
# dn: cn=ziia,ou=groups,dc=mycompany,dc=corp
# delete: member
# member: mail=john.doe@mycompany.com,ou=users,dc=mycompany,dc=corp
# EOF
# ldapdelete -x -W -D "cn=admin,dc=mycompany,dc=corp"  "mail=john.doe@mycompany.com,ou=users,dc=mycompany,dc=corp"
# https://access.redhat.com/documentation/en-US/Red_Hat_Directory_Server/8.2/html/Administration_Guide/Examples-of-common-ldapsearches.html
