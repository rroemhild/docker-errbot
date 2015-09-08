#!/bin/bash
set -e

readonly ERRBIN="/app/venv/bin/err.py"


is_set() {
    local var=$1

    [[ -n $var ]]
}


if ( is_set ${WAIT} ); then
    echo "Sleep ${WAIT} seconds before starting err..."
    sleep ${WAIT}
fi


exec ${ERRBIN} $@
