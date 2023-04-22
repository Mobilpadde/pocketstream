# Use the Go v1.20 (Alpine) as the building of litestream
FROM golang:1.20-alpine as builder-ls

# Add GCC
RUN apk add build-base

# Change the current directory
WORKDIR /work

# Set the install directory
ENV GOBIN=/work

# Install litestream
RUN CGO_ENABLED=1 go install -ldflags "-s -w" github.com/benbjohnson/litestream/cmd/litestream@latest

# Use the Go v1.20 (Alpine) as the building of pocketbase
FROM golang:1.20-alpine as builder-pb

# Add GCC
RUN apk add build-base

# Change the current directory
WORKDIR /work

# Set the install directory
ENV GOBIN=/work

# Install pocketbase
RUN CGO_ENABLED=1 go install -ldflags "-s -w" github.com/pocketbase/pocketbase/examples/base@latest

# Use latest pre-built litestream Docker image
FROM alpine

# Change the current directory
WORKDIR /

# Copy the built binary
COPY --from=builder-ls /work/litestream /bin/litestream
COPY --from=builder-pb /work/base /bin/pocketbase

# Copy the run-script
COPY scripts/run.sh run.sh

# Exposing :8090 as `pb serve` uses this port
EXPOSE 8090

# Make new directory for the database(s)
RUN mkdir /data

# Start everything
ENTRYPOINT [ "sh", "run.sh" ]