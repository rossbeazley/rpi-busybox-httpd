DOCKER_IMAGE_VERSION=0.0.1
DOCKER_IMAGE_NAME=registry:30000/rpi-busybox-httpd
DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

default: build

build:
	dockerize -t $(DOCKER_IMAGE_NAME) \
		--add-file www /www \
		--entry '/bin/busybox' \
		--cmd 'httpd -f -p 80 -h /www' \
		/bin/busybox
	docker tag -f $(DOCKER_IMAGE_NAME) $(DOCKER_IMAGE_NAME):latest
	docker build -t registry:30000/rpi-busybox-httpd .
	docker tag -f $(DOCKER_IMAGE_NAME) $(DOCKER_IMAGE_NAME):latest
	docker tag -f $(DOCKER_IMAGE_NAME) $(DOCKER_IMAGE_TAGNAME)

push:
	docker push $(DOCKER_IMAGE_NAME)

test:
	docker run --rm registry:30000/rpi-busybox-httpd /bin/busybox echo "Success."
