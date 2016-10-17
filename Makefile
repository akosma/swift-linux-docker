IMAGE_NAME = ubuntu-swift-dev
CONTAINER_NAME = swiftalps
CREATE_OPTS = --name="${CONTAINER_NAME}" --interactive --tty --privileged=true --hostname="${CONTAINER_NAME}" --user=swiftalps --entrypoint=zsh

image:
	docker build -t ${IMAGE_NAME} .

container:
	docker create ${CREATE_OPTS} ${IMAGE_NAME}

start:
	docker start ${CONTAINER_NAME}

attach:
	docker attach ${CONTAINER_NAME}

stop:
	docker stop ${CONTAINER_NAME}

clean-cont: stop
	docker rm ${CONTAINER_NAME}

clean-image: clean-cont
	docker rmi --force ${IMAGE_NAME}

clean-all: stop clean-cont clean-image

info:
	docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CONTAINER_NAME}; \
	docker images; \
	docker ps

