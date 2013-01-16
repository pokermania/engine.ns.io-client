REPORTER = dot
TESTS = $(find ./test -type f -name '*.js' ! -name 'common.js')

build: components
	@coffee -c lib/*.coffee
	@component build --standalone nsio
	@mv build/build.js build/engine.ns.io-client.js

components: component.json
	@component install --dev

clean:
	rm -fr components

test:
	mocha \
		--reporter $(REPORTER) \
		$(TESTS)

.PHONY: test
