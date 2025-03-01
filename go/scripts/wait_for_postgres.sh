#!/bin/bash

# Load the .env file.
source .env
set -e

# Set the timeout in seconds.
TIMEOUT=30

wait_for_postgres() {
    echo "Waiting for Postgres to start..."
    if timeout $TIMEOUT bash -c 'until psql -c "\q"; do sleep 2; done'; then
        echo "Postgres is ready!"
    else
        echo "Timeout reached. Postgres did not start within $TIMEOUT seconds."
        exit 1
    fi
}

wait_for_postgres
