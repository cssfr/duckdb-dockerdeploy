# Dockerfile
FROM datacatering/duckdb:v1.2.2
ENTRYPOINT ["/duckdb","-ui"]
