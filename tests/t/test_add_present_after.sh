echo 'TEST: add item already present in element from tail'
SomeVar='/bin:/usr/bin:/usr/local/bin'
oldval="$SomeVar"
ultramunge /usr/bin SomeVar after
[ "$SomeVar" = "$oldval" ]

