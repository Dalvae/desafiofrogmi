#!/bin/bash

set -e

host="$1"
shift
cmd="$@"

# Ensure DATABASE_PASSWORD is exported so psql can use it without prompting
export PGPASSWORD=$DATABASE_PASSWORD

until psql -h "$host" -U "postgres" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"
exec $cmd
