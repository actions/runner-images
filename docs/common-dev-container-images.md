# Common development container images on Ubuntu images

To save users from pulling frequently used development and test container images at job time,
every Packer-built Ubuntu VM image (22.04, 24.04, and 26.04, both x64 and arm64) pre-pulls a
fixed set of container images during the build. The list is declared in the `docker.images`
array of each image's `toolsets/toolset-*.json` file and pulled by
[`install-docker.sh`](../images/ubuntu/scripts/build/install-docker.sh).

> [!NOTE]
> `ubuntu-slim` is out of scope. It runs as an unprivileged container rather than a VM and only
> installs the Docker CLI, not the daemon (see
> [`install-docker-cli.sh`](../images/ubuntu-slim/scripts/build/install-docker-cli.sh)), so it
> cannot pull or run any container image, cached or otherwise.

## Images and pinned tags

| Repository | Pinned tag | Notes |
| --- | --- | --- |
| `postgres` | `18` | |
| `mysql` | `8.4` | |
| `node` | `24-bookworm` | Only this exact tag is cached; `node:latest` and other Node major versions are not. |
| `pgvector/pgvector` | `pg18` | Must track the PostgreSQL major version above. |
| `localstack/localstack` | `2026.10.6` | Requires a `LOCALSTACK_AUTH_TOKEN` to activate; see [Known limitations](#known-limitations). |
| `python` | `3.14-bookworm` | |
| `espressif/idf` | `v5.5.6` | Large image (~5.4 GB compressed per architecture); see [Known limitations](#known-limitations). |
| `mongo` | `8.0` | |
| `semgrep/semgrep` | `1.184.0` | |
| `golang` | `1.27-bookworm` | |

All tags above publish both `linux/amd64` and `linux/arm64` manifests, so the same list applies
unchanged to every supported Ubuntu architecture.

## Update policy

- Images are pulled fresh on every weekly image build, so a pinned tag is refreshed automatically
  whenever its upstream digest changes (for example, security patches to a `*-bookworm` base).
- Tags are intentionally pinned to a specific version/variant rather than `latest`, so that the
  cached image set is predictable and reproducible across builds.
- Moving to a new major/minor version (for example, `postgres:18` to `postgres:19`, or rebasing
  `node`/`python`/`golang` off a newer Debian release) is a deliberate change: open a pull request
  that updates the tag in all six `toolset-*.json` files together, and validate on both
  architectures before merging.
- Review pinned tags periodically for upstream end-of-life, and retire a tag promptly if its
  repository stops publishing updates for it.
- Adding or removing an image from this list follows the same
  [tool request process](../CONTRIBUTING.md#adding-a-new-tool-to-an-image) as any other tool.

## Verifying an image is present and usable

[`Tools.Tests.ps1`](../images/ubuntu/scripts/tests/Tools.Tests.ps1) contains a `CachedDockerImages`
Pester suite that runs after the pull step. For every entry in `docker.images` it:

1. Confirms the image is present locally (`docker images` lists it).
2. Runs the image with `--pull=never` and a lightweight, non-mutating command (for example
   `--version`, `node --version`, or `idf.py --version`) to prove it can actually execute, not just
   that the layers were downloaded.

The generated image README (for example
[`Ubuntu2404-Readme.md`](../images/ubuntu/Ubuntu2404-Readme.md)) lists the exact cached
repository, tag, and digest under **Cached Docker images**, produced by
`Get-CachedDockerImagesTableData` in
[`SoftwareReport.Common.psm1`](../images/ubuntu/scripts/docs-gen/SoftwareReport.Common.psm1).

## Known limitations

- **LocalStack requires an auth token.** The `localstack/localstack` image only activates its
  AWS service emulation when a `LOCALSTACK_AUTH_TOKEN` (or `LOCALSTACK_API_KEY`) is supplied at
  container start. Pre-pulling the image guarantees the layers are local, but it does not provide
  a license; users must still supply their own token to start LocalStack and use its services.
- **`espressif/idf` is large.** The pinned tag is approximately 5.4 GB compressed per
  architecture. This meaningfully increases image build time and the disk space consumed on the
  runner. If available disk space for user jobs becomes a concern, revisit whether this image
  should remain in the default cached set.
