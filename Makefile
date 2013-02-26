REPORTER = dot
TESTS = $(shell find ./test -type f -name '*.js' ! -name 'common.js')

MOCHA=$(shell which mocha || readlink -f node_modules/.bin/mocha)
COFFEE=$(shell which coffee || readlink -f node_modules/.bin/coffee)
COMPONENT=$(shell which component || readlink -f node_modules/.bin/component)

build: components
	@$(COFFEE) -c lib/*.coffee
	@$(COMPONENT) build --standalone nsio
	@mv build/build.js build/engine.ns.io-client.js

components: component.json
	@$(COMPONENT) install --dev

clean:
	@rm -fr components

test:
	@$(MOCHA) \
		--reporter $(REPORTER) \
		$(TESTS)

.PHONY: test
