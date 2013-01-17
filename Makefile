REPORTER = dot
TESTS = $(find ./test -type f -name '*.js' ! -name 'common.js')

COFFEE=$(shell readlink -f node_modules/.bin/coffee)
COMPONENT=$(shell readlink -f node_modules/.bin/component)

build: components
	@$(COFFEE) -c lib/*.coffee
	@$(COMPONENT) build --standalone nsio
	@mv build/build.js build/engine.ns.io-client.js

components: component.json
	@$(COMPONENT) install --dev

clean:
	rm -fr components

test:
	mocha \
		--reporter $(REPORTER) \
		$(TESTS)

.PHONY: test
