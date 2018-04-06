echo 'TEST: space in sequence variable value'
Something='a b:ab:ac:acd'
ultramunge "x" Something
[ "$Something" = 'x:a b:ab:ac:acd' ]
