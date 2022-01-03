FROM debian:stable
RUN apt-get update && \
    apt-get install -y python python-v*env && \
    apt-get clean && \
    addgroup --system --gid 1000 user && \
    adduser --home /app --disabled-password --gecos "" --uid 1000 --gid 1000 user
USER user
COPY plugin /app
WORKDIR /app

