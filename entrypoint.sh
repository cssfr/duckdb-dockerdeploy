#!/bin/sh
export DISPLAY=none

# 1) Launch DuckDB UI (binds to 127.0.0.1:4213)
duckdb /data/db.duckdb -ui &

# 2) Bring up nginx in foreground
exec nginx -g 'daemon off;'
