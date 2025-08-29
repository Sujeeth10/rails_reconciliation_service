#!/bin/bash
set -e
until pg_isready -h "${DATABASE_HOST:-db}" -p 5432 -U "${DATABASE_USERNAME:-postgres}" >/dev/null 2>&1; do
  echo 'Waiting for Postgres...'
  sleep 1
done
if [ -f Gemfile ]; then
  bundle check || bundle install
fi
exec "$@"
