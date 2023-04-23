set -e

# Restore the database if it does not already exist
litestream restore -v -if-db-not-exists -if-replica-exists -o /data/db $REPLICA_URL

# Run litestream with Pocketbase as it's sub-process
exec litestream replicate -exec "pocketbase serve --dir /data --http 0.0.0.0:8090"

# Heavily inspired by 🤫
# https://github.com/benbjohnson/litestream-docker-example/blob/main/scripts/run.sh
