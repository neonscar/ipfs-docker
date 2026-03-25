# Dockerfile
FROM debian:bookworm-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl ca-certificates bash \
    && rm -rf /var/lib/apt/lists/*

# Install IPFS (Kubo)
ENV IPFS_VERSION=v0.28.0

RUN curl -L https://dist.ipfs.tech/kubo/${IPFS_VERSION}/kubo_${IPFS_VERSION}_linux-amd64.tar.gz \
    -o kubo.tar.gz && \
    tar -xzf kubo.tar.gz && \
    cd kubo && \
    bash install.sh && \
    cd / && rm -rf kubo kubo.tar.gz

# Create IPFS repo directory
RUN mkdir -p /data/ipfs
RUN mkdir -p /data/files

# Expose ports
EXPOSE 4001 5001 8080

# Environment
ENV IPFS_PATH=/data/ipfs

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /data/files

ENTRYPOINT ["/entrypoint.sh"]
