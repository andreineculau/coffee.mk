# Custom
-include custom.mk

# PHONY
PHONY := test
.PHONY: $(PHONY)
$(PHONY):
	@$(MAKE) -f .coffee.mk/coffee.mk $@

# Default
.DEFAULT:
	@$(MAKE) -f .coffee.mk/coffee.mk $@
