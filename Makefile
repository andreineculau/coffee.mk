# Custom
-include custom.mk

# Default
.PHONY: force

%: force
	@$(MAKE) -f .coffee.mk/coffee.mk $@

force: ;
