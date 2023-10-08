# syntax=docker/dockerfile:experimental

# Use the Alpine Linux 3 base image
FROM alpine:3

# Define build arguments
ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETOS

# Set the maintainer label
LABEL maintainer="The Prometheus Authors <prometheus-developers@googlegroups.com>"

# Install required packages
RUN apk add --no-cache smartmontools wget

# Download and extract the smartctl_exporter binary
RUN wget -O /bin/smartctl_exporter https://github.com/prometheus-community/smartctl_exporter/releases/download/v0.11.0/smartctl_exporter-0.11.0.${TARGETOS}-${TARGETARCH}.tar.gz \
    && tar -xf /bin/smartctl_exporter -C /bin \
    && chmod +x /bin/smartctl_exporter

# Expose the port for the smartctl_exporter
EXPOSE 9633

# Set the user to nobody
USER nobody

# Specify the entry point for the container
ENTRYPOINT ["/bin/smartctl_exporter"]
