#!/bin/sh
export DISPLAY=none

# Remove any stale DB file
rm -f /data/db.duckdb

# Start DuckDB UI with a fresh file, background
duckdb /data/db.duckdb -ui &

# Start nginx
exec nginx -g 'daemon off;'
