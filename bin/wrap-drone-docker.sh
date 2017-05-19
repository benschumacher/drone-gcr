#!/bin/bash
set -eu

if [ "${PLUGIN_DEBUG:-}" = "true" ]; then
    set -x
fi

if [ -n "$PLUGIN_AUTH_KEY" ]; then
    export GCR_AUTH_KEY="${PLUGIN_AUTH_KEY}"
fi

#TMPFILE="$(mktemp -d)/keyfile.json"
TMPFILE=$(mktemp)
echo "${GCR_AUTH_KEY}" | base64 -d > "${TMPFILE}"
GCR_ACCOUNT=$(jq -r ".client_email" "${TMPFILE}")
gcloud auth activate-service-account "${GCR_ACCOUNT}" --key-file="${TMPFILE}"

# prepare these values for the drone-docker plugin
export DOCKER_REGISTRY DOCKER_USERNAME DOCKER_PASSWORD DOCKER_EMAIL
DOCKER_REGISTRY="${PLUGIN_REGISTRY:-gcr.io}"
DOCKER_USERNAME="_json_key"
DOCKER_PASSWORD="${GCR_AUTH_KEY}"
DOCKER_EMAIL="-"

# invoke the docker plugin
/bin/drone-docker "$@"
