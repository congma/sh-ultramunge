echo "TEST: add item not yet present in sequence"
SOME_VAR="/bin:/usr/bin"
ultramunge /opt/X11/bin SOME_VAR
[ "$SOME_VAR" = /opt/X11/bin:/bin:/usr/bin ]
