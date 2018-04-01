echo 'TEST: add item already present in element'
SOME_VAR='/bin:/usr/bin:/usr/local/bin'
oldval="$SOME_VAR"
ultramunge /usr/bin SOME_VAR
[ "$SOME_VAR" = "$oldval" ]
