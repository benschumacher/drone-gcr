# drone-gcr

[![Build Status](http://beta.drone.io/api/badges/drone-plugins/drone-gcr/status.svg)](http://beta.drone.io/drone-plugins/drone-gcr)
[![Coverage Status](https://aircover.co/badges/drone-plugins/drone-gcr/coverage.svg)](https://aircover.co/drone-plugins/drone-gcr)
[![](https://badge.imagelayers.io/plugins/drone-gcr:latest.svg)](https://imagelayers.io/?images=plugins/drone-gcr:latest 'Get your own badge on imagelayers.io')

Drone plugin to build and publish Docker images to Google Container Registry. For the usage information and a listing of the available options please take a look at [the docs](DOCS.md).

## Docker

Build the Docker image with the follow commands:

```
docker build --rm=true -t plugins/gcr .
```

### Usage

Execute from the working directory:


```sh
docker run --rm \
  -e PLUGIN_TAG=latest \
  -e PLUGIN_REPO=octocat/hello-world \
  -e "GCR_TOKEN=$(cat ~/google-key.json)" \
  -e GCR_REGISTRY=us.gcr.io \
  -e DRONE_COMMIT_SHA=d8dbe4d94f15fe89232e0402c6e8a0ddf21af3ab \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  --privileged \
  plugins/gcr --dry-run
```
