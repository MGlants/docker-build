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
RUN wget -O /tmp/smartctl_exporter.tar.gz https://github.com/prometheus-community/smartctl_exporter/releases/download/v0.11.0/smartctl_exporter-0.11.0.${TARGETOS}-${TARGETARCH}.tar.gz \
    && tar -xzf /tmp/smartctl_exporter.tar.gz -C /tmp \
    && mv /tmp/smartctl_exporter-0.11.0.${TARGETOS}-${TARGETARCH}/smartctl_exporter /bin/smartctl_exporter \
    && chmod +x /bin/smartctl_exporter \
    && rm -r /tmp/smartctl_exporter-0.11.0.${TARGETOS}-${TARGETARCH} /tmp/smartctl_exporter.tar.gz


# Expose the port for the smartctl_exporter
EXPOSE 9633

# Set the user to nobody
USER nobody

# Specify the entry point for the container
ENTRYPOINT ["/bin/smartctl_exporter"]
