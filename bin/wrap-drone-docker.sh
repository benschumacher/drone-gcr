#!/bin/sh
set -eu

# if debug enabled, then we'll echo commands (note: will leak keys)
if [ "${PLUGIN_DEBUG:-}" = "true" ]; then
    set -x
fi

# populate GCR_TOKEN from PLUGIN_TOKEN
if [ -n "$PLUGIN_TOKEN" ]; then
    export GCR_TOKEN
    GCR_TOKEN="${PLUGIN_TOKEN}"
fi

# attempt to detect JSON v. Baste64 encoding
if (echo "${PLUGIN_TOKEN}" | jq -e '.'); then
    GCR_TOKEN="${PLUGIN_TOKEN}"
else
    GCR_TOKEN="$(echo "${PLUGIN_TOKEN}" | base64 -d)"
fi

# set variables for using Docker with GCR
export DOCKER_REGISTRY DOCKER_USERNAME DOCKER_PASSWORD
DOCKER_REGISTRY="${PLUGIN_REGISTRY:-gcr.io}"
DOCKER_USERNAME="_json_key"
DOCKER_PASSWORD="${GCR_TOKEN}"

# invoke the docker plugin
exec /bin/drone-docker "$@"
