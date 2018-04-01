echo 'TEST: add new element to singleton sequence'
SEQ_VAR=/tmp
ultramunge /var/tmp SEQ_VAR after
[ "$SEQ_VAR" = /tmp:/var/tmp ]
