echo 'TEST: sneaky syntax in path-value'
rm -rf test_xxx
SOME_VAR=a:b:ab
ultramunge "'"'"$(mkdir test_xxx)"'"'" SOME_VAR
[ -d test_xxx ]
