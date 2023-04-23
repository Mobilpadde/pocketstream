# PocketStream

> A **pocket**base and lite**stream** combined Docker-image

This is inspired by [Ben Johnson](https://github.com/benbjohnson/litestream-docker-example)'s own Dockerfile example for [litestream](https://github.com/benbjohnson/litestream) and [Pocketbase](https://github.com/pocketbase/pocketbase).

I decided, for reasons unknown, to make an image with both litestream and pocketbase in one, as the example from Ben Johnson above.

This is simply my take.

## Run directly

This is ran in **almost** same way as the example mentioned above.

```sh
docker run \
  -p 8090:80890 \ # exposing of the pocketbase admin-UI - if wanted
  -v /path/to/litestream.yml:/etc/litestream.yml \ # your custom config for litestream
  -v ${PWD}:/data \ # only if you want the look at the data locally
  -e REPLICA_URL=s3://BUCKET/db \ # should probably be the same as in the litestream-config
  ghcr.io/mobilpadde/pocketstream
```

## As base image

Personally I'm probably going to use this way, as I might want to build further upon this.

```Dockerfile
FROM ghcr.io/mobilpadde/pocketstream
ENV REPLICA_URL=s3://BUCKET/db
```
