FROM ubuntu:24.04 AS base

ARG IMAGE_VERSION=1.0.0
ARG IMAGE_OWNER="GitHub"

ENV IMAGE_OWNER=$IMAGE_OWNER
ENV ImageVersion=$IMAGE_VERSION
ENV IMAGE_VERSION=$IMAGE_VERSION
ENV ImageOS="Linux"
ENV IMAGE_TARGET_PLATFORM="GitHub"
ENV POWERSHELL_DISTRIBUTION_CHANNEL="GitHub-Actions-$ImageOS"
ENV IMAGEDATA_NAME="ubuntu:24.04"
ENV NVM_DIR="/etc/skel/.nvm"
ENV HELPER_SCRIPTS="/tmp/scripts/helpers"
ENV INSTALLER_SCRIPT_FOLDER="/tmp/toolsets"

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

COPY scripts/build /tmp/scripts/build
COPY scripts/helpers /tmp/scripts/helpers
COPY toolsets/ /tmp/toolsets/
RUN find /tmp/scripts -name "*.sh" -type f -exec chmod +x {} \;

COPY scripts/entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

RUN apt-get update && apt-get upgrade -y && apt-get install -y sudo lsb-release jq dpkg && \
    touch /run/.containerenv && \
    /tmp/scripts/build/configure-apt.sh && \
    /tmp/scripts/build/configure-apt-sources.sh && \
    /tmp/scripts/build/install-apt-vital.sh && \
    /tmp/scripts/build/install-ms-repos.sh && \
    /tmp/scripts/build/configure-image-data-file.sh && \
    /tmp/scripts/build/configure-environment.sh && \
    /tmp/scripts/build/install-actions-cache.sh && \
    /tmp/scripts/build/install-apt-common.sh && \
    /tmp/scripts/build/install-azcopy.sh && \
    /tmp/scripts/build/install-azure-cli.sh && \
    /tmp/scripts/build/install-azure-devops-cli.sh && \
    /tmp/scripts/build/install-bicep.sh && \
    /tmp/scripts/build/install-aws-tools.sh && \
    /tmp/scripts/build/install-git.sh && \
    /tmp/scripts/build/install-git-lfs.sh && \
    /tmp/scripts/build/install-github-cli.sh && \
    /tmp/scripts/build/install-google-cloud-cli.sh && \
    /tmp/scripts/build/install-nvm.sh && \
    /tmp/scripts/build/install-nodejs.sh && \
    /tmp/scripts/build/install-powershell.sh && \
    /tmp/scripts/build/configure-dpkg.sh && \
    /tmp/scripts/build/install-yq.sh && \
    /tmp/scripts/build/install-python.sh && \
    /tmp/scripts/build/install-zstd.sh && \
    /tmp/scripts/build/install-pipx-packages.sh && \
    /tmp/scripts/build/configure-system.sh && \
    /tmp/scripts/helpers/cleanup.sh

ENTRYPOINT ["/opt/entrypoint.sh"]

CMD [ "bash" ]
