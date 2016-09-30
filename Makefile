.PHONY: example

install:
	@npm install
	@./node_modules/.bin/selenium-standalone install --version=2.50.1 --drivers.chrome.version=2.21
	@./node_modules/.bin/webdriver-manager update --standalone=0

run:
	@cd example && ../node_modules/.bin/webpack-dev-server --hot --inline --config ./webpack.config.js

build:
	@NODE_ENV=production ./node_modules/.bin/babel ./src -d lib --ignore '*.spec.js'

doc:
	@cd docs && jekyll server . --watch

test:
	@NODE_ENV=test ./node_modules/.bin/mocha \
		--require ignore-styles \
		--compilers js:babel-register \
		'./src/**/*.spec.js'

test-watch:
	@NODE_ENV=test ./node_modules/.bin/mocha \
		--require ignore-styles \
		--compilers js:babel-register \
		--watch \
		'./src/**/*.spec.js'

test-e2e:
	@cd example && ../node_modules/.bin/webpack
	@NODE_ENV=test node_modules/.bin/mocha \
		--require co-mocha \
		--timeout 10000 \
		./e2e/tests/server.js \
		./e2e/tests/*.js
