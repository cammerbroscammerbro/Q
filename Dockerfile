# Use Ubuntu as base
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    curl \
    libssl-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /quantumsafe

# Copy all project files
COPY . /quantumsafe

# Build liboqs
WORKDIR /quantumsafe/liboqs
RUN mkdir -p build && cd build && cmake .. && make -j$(nproc)

# Go back to main project
WORKDIR /quantumsafe

# ✅ Compile pqc_server.c correctly (your file path inside liboqs/build)
RUN gcc -o pqc_server liboqs/build/pqc_server.c -Iliboqs/build/include -Lliboqs/build/lib -loqs -lssl -lcrypto

# Expose server port (change if needed)
EXPOSE 8080

# Run the server
CMD ["./pqc_server"]
