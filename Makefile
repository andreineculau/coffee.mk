# Custom
-include custom.mk

# Default
.DEFAULT:
	@$(MAKE) -f .coffee.mk/coffee.mk $@
