Use this plugin to build and push Docker images to the Google Container Registry (GCR). Please read the GCR [documentation](https://cloud.google.com/container-registry/) before you begin. You will need to generate a [JSON token](https://developers.google.com/console/help/new/#serviceaccounts) to authenticate to the registry and push images.

The following parameters are used to configure this plugin:

* `registry` - authenticates to this registry (defaults to `gcr.io`)
* `token` - json token (can be base64 encoded)
* `repo` - repository name for the image (include registry base)
* `tags` - repository tag(s) for the image (defaults to `latest`)
* `storage_driver` - use `aufs`, `overlay`, or `vfs` driver

Sample configuration:

```yaml
publish:
  gcr:
    repo: foo/bar
    token: >
      {
        "private_key_id": "...",
        "private_key": "...",
        "client_email": "...",
        "client_id": "...",
        "type": "..."
      }
```

Sample configuration using multiple tags:

```
publish:
  gcr:
    repo: foo/bar
    tag:
      - latest
      - "1.0.1"
      - "1.0"
    token: >
      {
        "private_key_id": "...",
        "private_key": "...",
        "client_email": "...",
        "client_id": "...",
        "type": "..."
      }
```

## JSON Token

When setting your token in the `.drone.yml` file you must use [folded block scalars](http://www.yaml.org/spec/1.2/spec.html#id2796251) to avoid parsing errors:

```
publish:
  gcr:
    token: >
      {
        "private_key_id": "...",
        "private_key": "...",
        "client_email": "...",
        "client_id": "...",
        "type": "..."
      }
```

When injecting secrets you must also use a folded block scalar:

```
publish:
  gcr:
    token: >
      $GOOGLE_KEY
```

## Troubleshooting

For detailed output you can set the `DOCKER_LAUNCH_DEBUG` environment variable in your plugin configuration. This starts Docker with verbose logging enabled.

```
publish:
  gcr:
    environment:
      - DOCKER_LAUNCH_DEBUG=true
```

