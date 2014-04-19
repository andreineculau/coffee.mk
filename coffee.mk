SELF_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
# Util
-include $(SELF_DIR)util.mk/util.mk

# Setup
define coffee-compile
	@$(eval input := $<)
	@$(eval output := $@)
	@mkdir -p `dirname $(output)`
	@coffee -pc $(input) > $(output)
endef

define coffee-compile-shebang
	@$(eval input := $<)
	@$(eval output := $@)
	@mkdir -p `dirname $(output)`
	@( echo '#!/usr/bin/env node'; coffee -pc $(input) ) > $(output)
	@chmod +x $(output)
endef

COFFEE_INDEX := $(wildcard *.coffee)
COFFEE_BIN := $(shell find bin -type f -name '*.coffee' 2>/dev/null)
COFFEE_SRC := $(shell find src -type f -name '*.coffee' 2>/dev/null)
COFFEE_TEST := $(shell find test -type f -name '*.coffee' 2>/dev/null)
COFFEE := $(COFFEE_INDEX) $(COFFEE_BIN) $(COFFEE_SRC)
JS := $(patsubst src%, lib%, $(COFFEE:.coffee=.js))

# PHONY
.PHONY: install clean lint all prepublish publish tap test spec testem help Makefile custom.mk

all: $(JS)

install:
	@[ -d .git ] && git submodule update --init --recursive
	@npm install

clean:
	@rm -f $(JS)

lint:
	@coffeelint -f ./.coffeelint.json $(COFFEE) $(COFFEE_TEST)

prepublish: clean test all

publish:
	@npm publish

tap:
	@testem ci

test: lint
	@mocha --reporter min test

spec: lint
	@mocha --reporter spec test

testem: lint
	@testem

help: util-help

Makefile:
	@:

custom.mk:
	@:

util.mk/util.mk:
	@:

# Non PHONY
$(JS): $(1)

%.coffee: ;

bin/%.js: bin/%.coffee
	$(coffee-compile-shebang)

lib/%.js: src/%.coffee
	$(coffee-compile)

%.js: %.coffee
	$(coffee-compile)
