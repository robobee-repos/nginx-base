include ../utils/Makefile.help
include ../utils/Makefile.functions

export NAME := nginx

test: ##@targets Starts docker compose.
	docker-compose -p $(NAME) -f test.yaml up
.PHONY: up

rm:
	docker-compose -p $(NAME) -f test.yaml rm -f

clean: rm
