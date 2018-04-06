#!/bin/sh
# Usage: ultramunge VALUE NAME [after]
# Idempotently add VALUE to the PATH-style, colon-separated path list from the
# head (default) or tail (if "after" is given as the 3rd parameter) of the
# shell environment variable NAME.
ultramunge ()
{
    _UM_ITEM="$1"
    # Skip entire operation if the value to be added is empty.
    if [ -z "${_UM_ITEM}" ]; then
	return 0
    fi
    _UM_VNAME="$2"
    # Valid name must comform to the POSIX standard for environment variables
    # This also filters out sneaky names.
    if ! echo "${_UM_VNAME}" | grep -q '^[A-Z_][A-Z0-9_]*$'; then
	return 1
    fi
    # Dereference the expanded value of the named variable.
    # Similar to the Bash statement
    #     _UM_VVALUE="${!_UM_VNAME}"
    eval "_UM_VVALUE=\"\${${_UM_VNAME}}\""
    # If the mungee variable is already empty or non-set, just set it to the
    # given item.
    # shellcheck disable=SC2154
    if [ -z "${_UM_VVALUE}" ]; then
	_UM_HEAD="$( printf '%s' "${_UM_ITEM}" | base64 )"
	# shellcheck disable=SC2016
	_UM_SUBSTR='"$( printf "${_UM_HEAD}" | base64 --decode )"'
	eval "${_UM_VNAME}=${_UM_SUBSTR}"
    else
	_UM_PATTERN="(^|:)${_UM_ITEM}($|:)"
	# Test if the variable already contains the value as part.
	if ! echo "$_UM_VVALUE" | grep -Eq "${_UM_PATTERN}"; then
	    # Guarantee that neither the head nor the tail variables expands
	    # to anything containing the single-quote (') character.
	    if [ "$3" = after ]; then
		_UM_HEAD="$( printf '%s' "${_UM_VVALUE%:}" | base64 )"
		_UM_TAIL="$( printf '%s' "${_UM_ITEM}" | base64 )"
	    else
		# shellcheck disable=SC2034
		_UM_HEAD="$( printf '%s' "${_UM_ITEM}" | base64 )"
		# shellcheck disable=SC2034
		_UM_TAIL="$( printf '%s' "${_UM_VVALUE#:}" | base64 )"
	    fi
	    # The only user-expandable part of the following command string
	    # are encoded such that the alphabet is not large enough to contain
	    # characters necessary for code-injection.
	    # shellcheck disable=SC2016
	    _UM_SUBSTR='"$( printf "%s" "${_UM_HEAD}" | base64 --decode )":"$( printf "%s" "${_UM_TAIL}" | base64 --decode )"'
	    eval "${_UM_VNAME}=${_UM_SUBSTR}"
	fi
	# End of "test if the variable already contains the value as part".
    fi
    unset -v _UM_ITEM _UM_VNAME _UM_VVALUE _UM_HEAD _UM_TAIL _UM_SUBSTR \
	     _UM_PATTERN
}
