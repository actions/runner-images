#!/bin/bash -e
################################################################################
##  File:  install-container-tools.sh
##  Desc:  Install container tools: podman, buildah and skopeo onto the image
##  Supply chain security: podman static bundle - pinned version + SHA256 validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

# Ubuntu 22.04/24.04 only ship an outdated podman via apt (3.4.4 / 4.9.3) whose
# Docker-compatible API is too old for the current Docker daemon and breaks
# `podman push docker-daemon:` (actions/runner-images#13691, #549). There is no
# maintained podman apt repository for Ubuntu (Kubic/OBS was discontinued), so a
# current self-contained static bundle (podman + crun/runc + conmon + netavark +
# aardvark-dns + pasta) is installed instead. Ubuntu 26.04 already ships podman 5.x.
podman_static_tag="v5.8.4"
podman_static_sha256_amd64="a58765fe8be6ab3fb79f892f1a027b4ce4a7e8eb589df1ef960c167cbde08d69"
podman_static_sha256_arm64="a2f6b73cc0f7018e2e8518338a4ec27db70148e1af86e16719235605aefd1df3"

install_podman_static() {
    local arch checksum
    if is_x64; then
        arch="amd64"
        checksum="$podman_static_sha256_amd64"
    else
        arch="arm64"
        checksum="$podman_static_sha256_arm64"
    fi

    local archive_url="https://github.com/mgoltzsche/podman-static/releases/download/${podman_static_tag}/podman-linux-${arch}.tar.gz"
    local archive_path
    archive_path=$(download_with_retry "$archive_url")
    use_checksum_comparison "$archive_path" "$checksum"

    # The bundle ships ./usr and ./etc under a single top-level directory
    tar -xzf "$archive_path" -C / --strip-components=1 \
        "podman-linux-${arch}/usr" "podman-linux-${arch}/etc"
    rm -f "$archive_path"
}

apt-get update
if is_ubuntu26; then
    # apt already provides a current podman on 26.04
    apt-get install podman buildah skopeo
else
    # buildah and skopeo from apt (podman is not a dependency of either);
    # uidmap keeps rootless podman working; podman itself comes from the bundle
    apt-get install buildah skopeo uidmap
    install_podman_static
fi

mkdir -p /etc/containers
printf "[registries.search]\nregistries = ['docker.io', 'quay.io']\n" | tee /etc/containers/registries.conf

# netavark (used by podman 5.x) can default to nftables on Ubuntu and then fails
# name resolution; force iptables. https://github.com/actions/runner-images/issues/14230
mkdir -p /etc/containers/containers.conf.d
printf '[network]\nfirewall_driver = "iptables"\n' | tee /etc/containers/containers.conf.d/99-fix-firewall.conf
podman network reload --all 2>/dev/null || true

invoke_tests "Tools" "Containers"
