#!/bin/sh
export DISPLAY=none

# start an in-memory DuckDB UI
duckdb -ui &

# run nginx in foreground
exec nginx -g 'daemon off;'
