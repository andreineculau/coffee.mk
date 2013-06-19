# Setup
define coffee-compile
	@$(eval input := $<)
	@$(eval output := $@)
	@mkdir -p `dirname $(output)`
	@coffee -pc $(input) > $(output)
endef

COFFEE := $(wildcard *.coffee bin/*.coffee src/**/*.coffee)
JS := $(patsubst src%, lib%, $(COFFEE:.coffee=.js))

# PHONY
.PHONY: install clean lint all prepublish test tap testem Makefile custom.mk

all: $(JS)

install:
	[ -d .git ] && git submodule update --init --recursive
	@npm install

clean:
	@rm -f $(JS)

lint:
	@coffeelint -f ./.coffee.mk/.coffeelint.json $(COFFEE)

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

