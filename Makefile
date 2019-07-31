SUBDIRS := 1.4/*

.PHONY: build push clean version

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

version:
	for dir in $(SUBDIRS); do \
		make TAG=$${dir//\//-} -C $$dir $(MAKECMDGOALS); \
	done
