#!/bin/sh

export DISPLAY=none
duckdb /data/db.duckdb -ui 0.0.0.0
