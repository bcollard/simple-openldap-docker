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

