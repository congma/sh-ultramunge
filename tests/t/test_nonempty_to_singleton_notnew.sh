echo 'TEST: add singleton to itself'
_SEQ_var=/bin
oldval="${_SEQ_var}"
ultramunge "$oldval" _SEQ_var
[ "${_SEQ_var}" = "$oldval" ]
