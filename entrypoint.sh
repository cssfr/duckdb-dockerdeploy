#!/bin/sh
export DISPLAY=none

# Remove stale database file, if any
rm -f /data/db.duckdb

# Start DuckDB UI (in-memory)
duckdb -ui &

# Start nginx in foreground
exec nginx -g 'daemon off;'
