#!/bin/sh
# Black box test for run-time behaviour.

# Color keywords if stdout is a tty.
if [ -t 1 ]; then
    CBRed='\033[1;31m'
    CBGreen='\033[1;32m'
    CReset='\033[0m'
else
    CBRed=''
    CBGreen=''
    CReset=''
fi
TERM_PASS="${CBGreen}PASS${CReset}"
TERM_FAIL="${CBRed}FAIL${CReset}"

CUL_ST=0    # Counting failed tests.
CUL_ALL=0   # Counting run tests.
CUL_SKIP=0  # Skipped tests.

hrule () {
    echo --------------------
    echo
}

expect_true () {
    if ( . "$1" ); then
	printf '%b: %s\n' "$TERM_PASS" "$1"
	TEST_ST=0
    else
	printf '%b: %s\n' "$TERM_FAIL" "$1"
	TEST_ST=1
    fi
    CUL_ALL=$((CUL_ALL + 1))
    CUL_ST=$((CUL_ST + TEST_ST))
    hrule
}

expect_false () {
    if ( . "$1" ); then
	printf '%b: %s\n' "$TERM_FAIL" "$1"
	TEST_ST=1
    else
	printf '%b: %s\n' "$TERM_PASS" "$1"
	TEST_ST=0
    fi
    CUL_ALL=$((CUL_ALL + 1))
    CUL_ST=$((CUL_ST + TEST_ST))
    hrule
}

# args: conditional, expectation-kind, test-script, more-args
# neutralize code execution in conditional; expect non-empty string for true,
# and empty for false
with_cond () {
    if [ -n "$1" ]; then
	shift
	"$@"
    else
	CUL_SKIP=$((CUL_SKIP + 1))
	echo "SKIP: $*"
	hrule
    fi
}

. ../sh-ultramunge.sh

for script_name in t/*.sh; do
    [ -e "$script_name" ] || continue
    expect_true "$script_name"
done

for script_name in f/*.sh; do
    [ -e "$script_name" ] || continue
    expect_false "$script_name"
done

echo "Total run: $CUL_ALL"
echo "Total failed: $CUL_ST"
echo "Total skipped: $CUL_SKIP"

unset ultramunge
exit "$CUL_ST"
