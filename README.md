# PocketStream

> A **pocket**base and lite**stream** combined Docker-image

This is inspired by [Ben Johnson](https://github.com/benbjohnson/litestream-docker-example)'s own (offical) Docker image for [litestream](https://hub.docker.com/r/litestream/litestream).

> **Note**
>
> I would have loved to combine this with the offical pocketbase Docker-image as well, although this does not exist at the time of writing this.

I decided, for reasons unknown, to make an image with both litestream and pocketbase in one, as the example from Ben Johnson above.

This is simply my take.

---

Start of by building the image

```sh
docker build -t pocketstream .
```

Then run in **almost** same way as the one mentioned above.

```sh
docker run \
  -p 8090:80890 \ # exposing of the pocketbase admin-UI
  -v /path/to/litestream.yml:/etc/litestream.yml \ # your custom config for litestream
  -v ${PWD}:/data \ # only if you want the look at the data locally
  -e REPLICA_URL=s3://BUCKET/db \ # should probably be the same as in `litestream.yml`
  pocketstream
```
