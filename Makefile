SHELL := /bin/bash
.DEFAULT_GOAL := help
.PHONY: clean help install compile test build

envs := staging|production

help:
	@grep -h -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

clean: ## Removes temporary files from local folders

install: ## Installs dependencies
	npm install

test: install ## Executes unit tests
	npm test

build: clean install compile test ## Builds
	@if [[ -z "${version}" ]]; then echo "version must be provided"; false; fi;
	@echo "Build complete! at version $(version)"

pre-deploy-validation:
	@if [[ -z "${env}" ]]; then echo "env must be provided"; false; fi
	@if [[ ! "${env}" =~ ${envs} ]]; then echo "env must be one of ${envs}"; false; fi
	@if [[ -z "${version}" ]]; then echo "version must be provided"; false; fi

deploy: pre-deploy-validation ## Deploys to an environment
  # call deploy script
	@echo "Deploying version ${version} to environment ${env}"
