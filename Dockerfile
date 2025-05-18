FROM debian:bullseye-slim

# Install curl, unzip, nginx & certs
RUN apt-get update && \
    apt-get install -y \
      curl \
      unzip \
      nginx \
      ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install DuckDB CLI
RUN curl -L https://github.com/duckdb/duckdb/releases/latest/download/duckdb_cli-linux-amd64.zip \
     -o duckdb.zip \
  && unzip duckdb.zip \
  && mv duckdb /usr/local/bin/duckdb \
  && chmod +x /usr/local/bin/duckdb \
  && rm duckdb.zip

# Stub out xdg-open so UI watcher won't crash
RUN printf '#!/bin/sh\nexit 0\n' > /usr/local/bin/xdg-open \
 && chmod +x /usr/local/bin/xdg-open

# Create data dir
RUN mkdir -p /data

# Copy NGINX config + entrypoint
COPY default.conf /etc/nginx/conf.d/default.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose DuckDB UI port
EXPOSE 4213

CMD ["/entrypoint.sh"]
