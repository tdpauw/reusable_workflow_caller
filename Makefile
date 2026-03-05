SHELL := /bin/bash
.DEFAULT_GOAL := help
.PHONY: clean help install compile test build

help:
	@grep -h -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

clean: ## Removes temporary files from local folders

install: ## Installs dependencies
	npm install

test: ## Executes unit tests
	npm test

build: clean install compile test ## Builds
	$(info "Build complete! at version $(version)")
