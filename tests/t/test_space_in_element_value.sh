echo 'TEST: space in item'
Something='a b:ab:ac:acd'
ultramunge ' ' Something
[ "$Something" = ' :a b:ab:ac:acd' ]
