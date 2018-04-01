#!/bin/sh
# Usage: ultramunge VALUE NAME [after]
# Idempotently add VALUE to the PATH-style, colon-separated path list from the
# head (default) or tail (if "after" is given as the 3rd parameter) of the
# shell environment variable NAME.
ultramunge ()
{
    path_value="$1"
    # Skip entire operation if the value to be added is empty.
    if [ -z "$path_value" ]; then
	return 0
    fi
    variable_name="$2"
    # Valid name must comform to the POSIX standard for environment variables
    # This also filters out sneaky names.
    if ! echo "${variable_name}" | grep -q '^[A-Z_][A-Z0-9_]*$'; then
	return 1
    fi
    # Dereference the expanded value of the named variable.
    # Similar to the Bash statement
    #     variable_value="${!variable_name}"
    eval "variable_value=\"\${${variable_name}}\""
    # Prevent injection by closing the single quote. Reject all values
    # containing the single quote character.
    # shellcheck disable=SC2154
    if echo "${variable_value}""${path_value}" | grep -q "'"; then
	return 1
    fi
    # Set the named variable to the appended value.
    # shellcheck disable=SC2154
    if [ -z "${variable_value}" ]; then
	eval "${variable_name}='${path_value}'"
    else
	pattern="(^|:)${path_value}($|:)"
	if ! echo "$variable_value" | grep -Eq "$pattern"; then
	    if [ "$3" = after ]; then
		eval "${variable_name}='${variable_value%:}:${path_value}'"
	    else
		eval "${variable_name}='${path_value}:${variable_value#:}'"
	    fi
	fi
    fi
}
