REPOSITORY := erwin82
NAME := nginx
VERSION ?= 1.13.1-r1

build: _build ##@targets Builds the docker image.

clean: _clean ##@targets Removes the local docker image.

deploy: _deploy ##@targets Deploys the docker image to the repository.

include Makefile.help
include Makefile.functions
include Makefile.image

.PHONY +: build clean deploy
