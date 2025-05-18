# Dockerfile
FROM datacatering/duckdb:v1.2.2

# install xdg-open so the CLI can launch (and succeed at) opening a browser
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && apt-get install -y --no-install-recommends xdg-utils \
 && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/duckdb", "-ui"]
