FROM debian:bullseye-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    nginx \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install DuckDB CLI
RUN curl -L https://github.com/duckdb/duckdb/releases/latest/download/duckdb_cli-linux-amd64.zip -o duckdb.zip \
    && unzip duckdb.zip \
    && mv duckdb /usr/local/bin/duckdb \
    && chmod +x /usr/local/bin/duckdb \
    && rm duckdb.zip

# Stub xdg-open
RUN printf '#!/bin/sh\nexit 0\n' > /usr/local/bin/xdg-open \
    && chmod +x /usr/local/bin/xdg-open

# Clean default nginx configs to avoid conflicts
RUN rm -f /etc/nginx/sites-enabled/default /etc/nginx/conf.d/default.conf

# Create data dir
RUN mkdir -p /data

# Copy custom nginx config and entrypoint
COPY default.conf /etc/nginx/conf.d/duckdb-ui.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 80

CMD ["/entrypoint.sh"]
