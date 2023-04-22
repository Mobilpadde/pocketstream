set -e

# Restore the database if it does not already exist
if [ -f /data/db ]; then
  echo "Database already exists, skipping restore"
else
  echo "No database found, restoring from replica if exists"
  litestream restore -v -if-replica-exists -o /data/db "${REPLICA_URL}"
fi

# Run litestream with your Pocketbase as the sub-process
exec litestream replicate -exec "pocketbase serve --dir /data --http 0.0.0.0:8090"

# Heavily inspired by 🤫
# https://github.com/benbjohnson/litestream-docker-example/blob/main/scripts/run.sh
