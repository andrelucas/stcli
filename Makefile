
IMAGE	= andrelucas/stcli
TAG		= latest

all: storageos image push

.PHONY: image push

storageos:
	dapper

image:
	docker build -t $(IMAGE):$(TAG) --rm .

push:
	docker push $(IMAGE):$(TAG)

clean:
	rm -f storageos

distclean:
	docker rmi $(IMAGE):$(TAG)
