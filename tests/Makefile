all: cov covreport

cov:
	kcov cov --exclude-pattern='runall.sh' --exclude-pattern='test*.sh' --include-path='../sh-ultramunge.sh' ./runall.sh

covreport: cov
	python report.py

clean:
	rm -rf cov

.PHONY: all covreport clean
