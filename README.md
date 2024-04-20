## Description

This is a docker image for [publishing Logseq graph](https://docs.logseq.com/#/page/publishing) 
inspired by the official solution [logseq-publish-spa](https://github.com/logseq/publish-spa).
You can publish a Single Page Application (SPA) from a Logseq graph on a docker-supported server 
without configuring development environments.

## Usage

**Note: The image consume \~7GB after the build (even with the alpine basis).**

### With `docker build` manually

```sh
$ git clone https://github.com/logseq/publish-spa
$ cd publish-spa/docker
$ docker build -t logseq-publish-spa -f Dockerfile .
# Or use the Dockerfile.alpine
# Run the image
$ docker run -v ./graph:/graph:ro -v ./out:/out -e PUB_THEME=light -it logseq-publish-spa
```

Several environment variables are provided:

- `PUB_THEME`: Theme mode for frontend. Can be "dark" or "light". Defaults to "light".
- `PUB_ACCENT_COLOR`: Accent color for frontend. Can be one of "tomato", "red", "crimson", "pink", "plum", "purple", "violet", "indigo", "blue", "cyan", "teal", "green", "grass", "orange", "brown". Defaults to "blue".
- `PUB_GRAPH_DIR`: Graph directory **in container**, defaults to `/graph`.
- `PUB_OUT_DIR`: Output directory **in container**, defaults to `/out`.

### With docker compose

```sh
$ git clone https://github.com/logseq/publish-spa
$ cd publish-spa/docker
```

Then modify the `docker-compose.yml` file to match your preferred configuration.

```sh
# Run the container
$ docker compose up
```

### Change the version of Logseq

Modify the `LOGSEQ_VERSION` and `LOGSEQ_PUBSPA_VERSION` in Dockerfile:
```dockerfile
# See https://github.com/logseq/publish-spa/tags
ARG LOGSEQ_PUBSPA_VERSION=0.3.1 
# See https://github.com/logseq/logseq/tags
ARG LOGSEQ_VERSION=0.10.6
```

### Pre-built images

Not available currently. Welcome for PRs.

## LICENSE
See LICENSE.md

## Additional Links
* https://github.com/logseq/publish-spa - The main dependency of this repo.
* https://github.com/logseq/logseq - An awesome knowlege management tool.
