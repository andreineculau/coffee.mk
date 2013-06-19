# Default
%: force
	@$(MAKE) -f .coffee.mk/coffee.mk $@

force: ;

# Custom
-include custom.mk
