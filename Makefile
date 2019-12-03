ORGANIZATION = agolub
CONTAINER = task-databrewery
VERSION = 1.0.0


pull :
	docker-compose pull

up : pull
	docker-compose up -d

up_local :
	docker-compose up -d --no-build

down :
	docker-compose down

build :
	docker build -t $(ORGANIZATION)/$(CONTAINER):$(VERSION) .

run :
	docker run --rm --name $(CONTAINER) \
		-v ${PWD}/scripts:/srv/workdir/scripts \
		-it $(ORGANIZATION)/$(CONTAINER):$(VERSION) /bin/sh -c 'cd scripts; ipa read web.earthquake'

shell:
	docker exec -it $(CONTAINER) /bin/bash
