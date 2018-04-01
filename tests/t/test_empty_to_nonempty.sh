echo 'TEST: add empty value to non-empty sequence'
SOME_VAR='/bin'
oldval="$SOME_VAR"
ultramunge '' SOME_VAR
[ "$SOME_VAR" = "$oldval" ]
