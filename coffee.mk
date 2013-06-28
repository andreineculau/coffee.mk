# Setup
define coffee-compile
	@$(eval input := $<)
	@$(eval output := $@)
	@mkdir -p `dirname $(output)`
	@coffee -pc $(input) > $(output)
endef

COFFEE_INDEX := $(wildcard *.coffee)
COFFEE_BIN := $(shell find bin -type f -name '*.coffee' 2>/dev/null)
COFFEE_SRC := $(shell find src -type f -name '*.coffee' 2>/dev/null)
COFFEE := $(COFFEE_INDEX) $(COFFEE_BIN) $(COFFEE_SRC)
JS := $(patsubst src%, lib%, $(COFFEE:.coffee=.js))

# PHONY
.PHONY: install clean lint all prepublish test tap testem Makefile custom.mk

all: $(JS)

install:
	@[ -d .git ] && git submodule update --init --recursive
	@npm install

clean:
	@rm -f $(JS)

lint:
	@coffeelint -f ./.coffeelint.json $(COFFEE)

prepublish: clean lint all

test:
	@mocha --reporter spec test

tap:
	@testem ci

testem:
	@testem

Makefile:
	@:

custom.mk:
	@:

# Non PHONY
$(JS): $(1)

%.coffee: ;

%.js: %.coffee
	$(coffee-compile)

lib/%.js: src/%.coffee
	$(coffee-compile)

