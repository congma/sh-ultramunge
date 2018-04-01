test:
	$(MAKE) -C tests all

covreport:
	$(MAKE) -C tests covreport

clean:
	$(MAKE) -C tests clean

.PHONY: test clean covreport
