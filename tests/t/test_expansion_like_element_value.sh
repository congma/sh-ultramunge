echo 'TEST: expansion-like syntax in element value'
SOME_VAR=a:b:ab:ac:acd
ultramunge '$SHELL' SOME_VAR after
[ "$SOME_VAR" = 'a:b:ab:ac:acd:$SHELL' ]
