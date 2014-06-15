SHELL = /usr/bin/env bash
SELF_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
# Custom
-include custom.mk

# PHONY
PHONY := test
.PHONY: $(PHONY)
$(PHONY):
	@$(MAKE) -f $(SELF_DIR)coffee.mk $@

# Default
.DEFAULT:
	@$(MAKE) -f $(SELF_DIR)coffee.mk $@
