#!/bin/bash
set -e

readonly ERRBIN="/app/venv/bin/errbot"
readonly ERRRUN="/srv"


is_set() {
    local var=$1

    [[ -n $var ]]
}


file_exist() {
    local file=$1

    [[ -e $file ]]
}


# if mounted volume is empty create dirs
if [ ! "$(ls -A ${ERRRUN})" ]; then
    mkdir "${ERRRUN}/data" "${ERRRUN}/plugins" "${ERRRUN}/errbackends"
fi


# copy default container image config file if not exist on volume
file_exist ${ERRCONF} \
    || cp /app/config.py ${ERRRUN}


# sleep if we need to wait for another container
if ( is_set ${WAIT} ); then
    echo "Sleep ${WAIT} seconds before starting err..."
    sleep ${WAIT}
fi


exec ${ERRBIN} $@
