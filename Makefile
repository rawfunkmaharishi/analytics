PROJECT = $(shell basename $(shell pwd))
ID = rawfunkmaharishi/${PROJECT}
LATEST = $(shell ls -tr1 data/ | sort | tail -1)

default: build

build:
	docker build -t ${ID} .

push:
	docker push ${ID}

run:
	docker run \
	--volume $(shell pwd)/${PROJECT}:/opt/${PROJECT} \
	--volume $(shell pwd)/data:/opt/data \
	--interactive \
	--tty \
	${ID} bash

anaylyse:
	docker run \
		--volume $(shell pwd)/data:/opt/data \
		--interactive \
		--tty \
		${ID} ruby analyse.rb /opt/data/${LATEST}

# # this is flat-out juju
# # https://stackoverflow.com/a/7367903
# guard-%:
# 	@ if [ -z "${${*}}" ]; then \
#   	echo "You must provide the $* variable"; \
#   	exit 1; \
# 	fi