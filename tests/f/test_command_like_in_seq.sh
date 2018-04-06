echo 'TEST: sneaky syntax in the old value of sequence variable'
rm -rf test_yyy
SOME_VAR='/bin:";mkdir test_yyy'
ultramunge thing SOME_VAR after
[ -d test_yyy ]
