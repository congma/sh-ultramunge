echo 'TEST: add item already present in element from tail'
SOME_VAR='/bin:/usr/bin:/usr/local/bin'
oldval="$SOME_VAR"
ultramunge /usr/bin SOME_VAR after
[ "$SOME_VAR" = "$oldval" ]

