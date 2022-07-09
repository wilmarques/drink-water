# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.238.1/containers/debian/.devcontainer/base.Dockerfile

# [Choice] Debian version (use bullseye on local arm64/Apple Silicon): bullseye, buster
ARG VARIANT="buster"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

USER vscode
WORKDIR /home/vscode

# ** [Optional] Uncomment this section to install additional packages. **
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

############################################################
######################### FLUTTER ##########################
############################################################

ENV FLUTTER_HOME="/home/vscode/.flutter"

RUN git clone https://github.com/flutter/flutter -b stable $FLUTTER_HOME && \
  .flutter/bin/flutter channel stable && \
  .flutter/bin/flutter upgrade && \
  .flutter/bin/flutter precache && \
  .flutter/bin/flutter --version

ENV PATH="$FLUTTER_HOME/bin:$PATH"
ENV PUB_CACHE="$FLUTTER_HOME/.pub_cache"

############################################################
############################ WEB ###########################
############################################################

# Install Google Chrome
USER root
RUN apt-get update \
  && apt-get install -y apt-transport-https \
  && curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update \
  && sudo apt-get install -y google-chrome-stable
