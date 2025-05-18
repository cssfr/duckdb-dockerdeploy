FROM debian:bullseye-slim

# 1) Install dependencies + socat
RUN apt-get update && \
    apt-get install -y curl unzip socat ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# 2) Install DuckDB CLI
RUN curl -L https://github.com/duckdb/duckdb/releases/latest/download/duckdb_cli-linux-amd64.zip -o duckdb.zip \
 && unzip duckdb.zip \
 && mv duckdb /usr/local/bin/duckdb \
 && chmod +x /usr/local/bin/duckdb \
 && rm duckdb.zip

# 3) Stub out xdg-open so it never fails/crashes
RUN printf '#!/bin/sh\nexit 0\n' > /usr/local/bin/xdg-open \
 && chmod +x /usr/local/bin/xdg-open

# 4) Create data dir for persistence
RUN mkdir -p /data

# 5) Copy our entrypoint launcher
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 6) Expose the UI port
EXPOSE 4213

CMD ["/entrypoint.sh"]
