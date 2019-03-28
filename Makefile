SUBDIRS := 1.4.1/debian-aws 1.4.1/debian-sumologic

.PHONY: build push clean

build:
	for dir in $(SUBDIRS); do \
		make TAG=$${dir//\//-} -C $$dir $(MAKECMDGOALS); \
	done

push:
	for dir in $(SUBDIRS); do \
		make TAG=$${dir//\//-} -C $$dir $(MAKECMDGOALS); \
	done

clean:
	for dir in $(SUBDIRS); do \
		make TAG=$${dir//\//-} -C $$dir $(MAKECMDGOALS); \
	done
