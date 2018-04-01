echo 'TEST: extra colons'
SOME_VAR=a:b::
ultramunge c SOME_VAR after
OTHER_VAR=:y:z
ultramunge x OTHER_VAR
[ "$SOME_VAR" = 'a:b::c' ] && [ "$OTHER_VAR" = 'x:y:z' ]
