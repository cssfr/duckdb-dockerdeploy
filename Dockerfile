# Dockerfile
FROM datacatering/duckdb:latest
ENTRYPOINT ["/duckdb", "-ui"]
