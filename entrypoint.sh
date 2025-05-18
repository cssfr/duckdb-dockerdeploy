#!/bin/sh
export DISPLAY=none

# Launch DuckDB UI in the background (127.0.0.1:4213)
duckdb -ui &

# Start NGINX in foreground
exec nginx -g 'daemon off;'
