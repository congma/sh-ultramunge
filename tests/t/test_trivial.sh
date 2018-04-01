echo 'TEST: add empty element to empty sequence'
SOME_VAR=
ultramunge '' SOME_VAR
[ -z "$SOME_VAR" ]
