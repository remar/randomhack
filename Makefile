default:
	@echo Available target: clean

clean:
	$(MAKE) -C src clean
	$(MAKE) -C test clean
