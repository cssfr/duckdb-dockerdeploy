#!/bin/sh
# Prevent any GUI-launching logic
export DISPLAY=none

# 1) Start the DuckDB UI (binds to localhost:4213)
duckdb /data/db.duckdb -ui &

# 2) Forward all traffic from 0.0.0.0:4213 → localhost:4213
#    Now Docker’s port mapping will actually see a listener.
socat TCP-LISTEN:4213,fork TCP:127.0.0.1:4213
