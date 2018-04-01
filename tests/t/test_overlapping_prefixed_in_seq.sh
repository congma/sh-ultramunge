echo 'TEST: overlapping prefixes in sequence elements'
TEST_VAR0='a:ab:abc'
ultramunge abd TEST_VAR0
[ "$TEST_VAR0" = 'abd:a:ab:abc' ]
