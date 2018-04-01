echo "TEST: add item not yet present in sequence to tail"
SOME_VAR="/bin:/usr/bin"
ultramunge /opt/X11/bin SOME_VAR after
[ "$SOME_VAR" = /bin:/usr/bin:/opt/X11/bin ]
