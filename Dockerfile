ARG DEBIAN_VERSION=buster-20201012-slim
ARG NODE_VERSION=16.17.0


# Build final image
FROM debian:${DEBIAN_VERSION}
LABEL maintainer="Roi Nagar"
ARG NODE_VERSION
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    git=1:2.20.1-2+deb10u3 \
    curl=7.64.0-4+deb10u3 \
    unzip=6.0-23+deb10u2 \
    jq=1.5+dfsg-2+b1 \
    ca-certificates \
    groff \
    less \
    python3 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
RUN groupadd --gid 1000 nonroot \
  # user needs a home folder to store credentials
  && useradd --gid nonroot --create-home --uid 1000 nonroot \
  && chown nonroot:nonroot /workspace && mkdir /home/nonroot/workspace
USER nonroot

ENTRYPOINT ["/bin/bash"]
