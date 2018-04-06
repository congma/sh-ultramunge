echo 'TEST: non-printable character'
_VAR_S0METHING="$( printf '\001%s' 'a' )"
ultramunge /bin _VAR_S0METHING
[ "${_VAR_S0METHING}" = "$( printf '%s:\001a' '/bin' )" ]
