echo 'TEST: expansion-like syntax in sequence'
SOME_VAR='${SHELL}'
ultramunge a SOME_VAR
[ "$SOME_VAR" = 'a:${SHELL}' ]
