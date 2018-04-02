all: cov covreport

cov: ../sh-ultramunge.sh
	kcov --bash-method=PS4 --bash-dont-parse-binary-dir --bash-handle-sh-invocation --exclude-pattern='runall.sh' --exclude-pattern='test*.sh' --include-path='../sh-ultramunge.sh' cov ./runall.sh

covreport: cov
	python report.py

clean:
	rm -rf cov

.PHONY: all clean
