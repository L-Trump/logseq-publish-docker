## Description

This is a docker image for [publishing Logseq graph](https://docs.logseq.com/#/page/publishing) 
inspired by the official solution [logseq-publish-spa](https://github.com/logseq/publish-spa).
You can publish a Single Page Application (SPA) from a Logseq graph on a docker-supported server 
without configuring development environments.

## Usage

**Note: The image consume \~7GB disk space during the build (even with the alpine basis).
The final image size is at ~700 MB thanks to the multistage build. So it is recommended to 
use the pre-built images first**

### With pre-built images

Pre-built images are available in ghcr.io. See https://ghcr.io/l-trump/logseq-publish-spa .

```sh
$ docker run -v ./graph:/graph:ro -v ./out:/out \
    -e PUB_THEME=light -it ghcr.io/l-trump/logseq-publish-spa:alpine
```

Three labels are tagged for latest images:

- `latest`: The latest version of the debian-based image.
- `alpine`: The latest version of the alpine-based image.
- `watch`: The image monitoring graphic changes and publishing them automatically.

Several generic environment variables are provided:

- `PUB_THEME`: Theme mode for frontend. Can be "dark" or "light". Defaults to "light".
- `PUB_ACCENT_COLOR`: Accent color for frontend. Can be one of "tomato", "red", "crimson", "pink", "plum", "purple", "violet", "indigo", "blue", "cyan", "teal", "green", "grass", "orange", "brown". Defaults to "blue".
- `PUB_GRAPH_DIR`: Graph directory **in container**, defaults to `/graph`.
- `PUB_OUT_DIR`: Output directory **in container**, defaults to `/out`.

### Auto monitor and publish

The `watch` image provides the ability to monitor graph changes and publish the new graph automatically.

```sh
$ docker run -v ./graph:/graph:ro -v ./out:/out \
    -e PUB_THEME=light -e MONITOR_INTERVAL=60 \
    -it ghcr.io/l-trump/logseq-publish-spa:watch
```

This image uses inotify to monitor the graph changes. When a change is detected, the script waits until `MONITOR_INTERVAL` seconds after the graph stops changing, and then publishes the graph.

Two environment variables are provided for watch image:

- `MONITOR_INTERVAL`: The inverval for script to wait for graph stops changing, defaults to `60`s.
- `MONITOR_DIR`: The directory to monitor, defaults to the same as `PUB_GRAPH_DIR`.

### With docker compose

```sh
$ git clone https://github.com/L-Trump/logseq-publish-docker
# Modify the docker-compose.yaml file. Then run the container
# For latest/alpine image
$ docker compose up
# For watch image
$ docker compose -f ./docker-compose.watch.yml up -d
```

Remember to modify the `docker-compose.yml` file to match your preferred configuration.

### With `docker build` manually

Note that building the image requires \~7GB disk space!

```sh
$ git clone https://github.com/L-Trump/logseq-publish-docker
$ cd publish-spa/docker
$ docker build -t logseq-publish-spa -f Dockerfile .
# Or use the Dockerfile.alpine
# Run the image
$ docker run -v ./graph:/graph:ro -v ./out:/out -e PUB_THEME=light -it logseq-publish-spa
```

### Change the version of Logseq

Modify the `LOGSEQ_VERSION` and `LOGSEQ_PUBSPA_VERSION` in Dockerfile:
```dockerfile
# See https://github.com/logseq/publish-spa/tags
ARG LOGSEQ_PUBSPA_VERSION=0.3.1 
# See https://github.com/logseq/logseq/tags
ARG LOGSEQ_VERSION=0.10.6
```

## LICENSE
See LICENSE.md

## Additional Links
* https://github.com/logseq/publish-spa - The main dependency of this repo.
* https://github.com/logseq/logseq - An awesome knowlege management tool.
