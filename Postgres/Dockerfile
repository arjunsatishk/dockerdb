FROM postgres:16
#FROM postgres:16-alpine
#FROM postgres:latest
#FROM postgres:alpine

# Install necessary build dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        postgresql-server-dev-16 \
        cmake \
        flex \
        bison \
    && rm -rf /var/lib/apt/lists/*

# Clone, build, and install pgvector. sslVerify is disabled as image is intended for educational purposes only.
WORKDIR /tmp
RUN git -c http.sslVerify=false clone https://github.com/pgvector/pgvector.git \
    && cd pgvector \
    && make \
    && make install

# Clone, build, and install Apache AGE. sslVerify is disabled as image is intended for educational purposes only.
WORKDIR /tmp
RUN git -c http.sslVerify=false clone https://github.com/apache/age.git \
    && cd age \
    && make PG_CONFIG=/usr/bin/pg_config \
    && make install PG_CONFIG=/usr/bin/pg_config

# Clean up build dependencies and temporary files to reduce image size
RUN apt-get remove --purge -y \
        build-essential \
        git \
        postgresql-server-dev-16 \
        cmake \
        flex \
        bison \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /tmp/pgvector /tmp/age
