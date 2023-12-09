#!/bin/sh

# Load the .env file.
source ../.env
set -e

until psql -c '\q';
do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up"
