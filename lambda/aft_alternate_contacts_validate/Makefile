PROJECT = aft_alternate_contacts_validate
FUNCTION = $(PROJECT)
DIST_DIR ?= "$(BASE)"

all: build

.PHONY: clean build

clean:
	rm -rf build

build: clean
	mkdir -p build
	python3 -m venv build/$(FUNCTION)
	. build/$(FUNCTION)/bin/activate; \
	pip3 install  -r requirements.txt -t ./ ;