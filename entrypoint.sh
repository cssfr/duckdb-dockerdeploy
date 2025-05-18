#!/bin/sh

export DISPLAY=none

# Start DuckDB UI in the background
duckdb /data/db.duckdb -ui &

# Keep the container running
tail -f /dev/null
