#!/bin/sh
set -eu

if [ "${PLUGIN_DEBUG:-}" = "true" ]; then
    set -x
fi

if [ -n "$PLUGIN_AUTH_KEY" ]; then
    export GCR_AUTH_KEY
    if (echo "${PLUGIN_AUTH_KEY}" | jq -e '.'); then
        GCR_AUTH_KEY="${PLUGIN_AUTH_KEY}"
    else
        GCR_AUTH_KEY="$(echo "${PLUGIN_AUTH_KEY}" | base64 -d)"
    fi
fi

TMPFILE=$(mktemp)
echo "${GCR_AUTH_KEY}" > "${TMPFILE}"
GCR_ACCOUNT=$(jq -r ".client_email" "${TMPFILE}")

# set variables for using Docker with GCR
export DOCKER_REGISTRY DOCKER_USERNAME DOCKER_PASSWORD
DOCKER_REGISTRY="${PLUGIN_REGISTRY:-gcr.io}"
DOCKER_USERNAME="_json_key"
DOCKER_PASSWORD="${GCR_AUTH_KEY}"

# invoke the docker plugin
exec /bin/drone-docker "$@"
