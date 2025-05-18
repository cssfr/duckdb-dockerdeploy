FROM debian:bullseye-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Download DuckDB CLI
RUN curl -L https://github.com/duckdb/duckdb/releases/latest/download/duckdb_cli-linux-amd64.zip -o duckdb.zip \
  && unzip duckdb.zip \
  && mv duckdb /usr/local/bin/duckdb \
  && chmod +x /usr/local/bin/duckdb \
  && rm duckdb.zip

# stub out xdg-open so DuckDB won’t try to launch a browser
RUN printf '#!/bin/sh\nexit 0' > /usr/local/bin/xdg-open \
  && chmod +x /usr/local/bin/xdg-open

# Create data dir
RUN mkdir -p /data

# Copy your entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 4213
CMD ["/entrypoint.sh"]
