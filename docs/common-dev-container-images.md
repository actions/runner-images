# Common development container images on Ubuntu images

To save users from pulling frequently used development and test container images at job time,
every Packer-built Ubuntu VM image (22.04, 24.04, and 26.04, both x64 and arm64) pre-pulls a
fixed set of container images during the build. The list is declared in the `docker.images`
array of each image's `toolsets/toolset-*.json` file and pulled by
[`install-docker.sh`](../images/ubuntu/scripts/build/install-docker.sh). Nine images are cached;
a tenth requested image, `espressif/idf`, is intentionally excluded — see
[Known limitations](#known-limitations).

> [!NOTE]
> `ubuntu-slim` is out of scope. It runs as an unprivileged container rather than a VM and only
> installs the Docker CLI, not the daemon (see
> [`install-docker-cli.sh`](../images/ubuntu-slim/scripts/build/install-docker-cli.sh)), so it
> cannot pull or run any container image, cached or otherwise.

## Relationship to other pre-pulled images

[`install-docker.sh`](../images/ubuntu/scripts/build/install-docker.sh) also unconditionally pulls
a handful of `:latest` images (the Dependabot updater and the GitHub Agentic Workflows/`gh-aw`
images) on every Ubuntu version except 22.04. Those pulls predate this toolset-driven list, serve
GitHub's own internal infrastructure rather than general user workloads, and are intentionally
*not* declared in `docker.images`: they're always `latest` rather than version-pinned, so they
don't fit the update policy below. They aren't part of this document's scope.

## Images and pinned tags

| Repository | Pinned tag | Notes |
| --- | --- | --- |
| `postgres` | `18` | |
| `mysql` | `8.4` | |
| `node` | `24-bookworm` | Only this exact tag is cached; `node:latest` and other Node major versions are not. |
| `pgvector/pgvector` | `pg18` | Must track the PostgreSQL major version above. |
| `localstack/localstack` | `2026.10.6` | Requires a `LOCALSTACK_AUTH_TOKEN` to activate; see [Known limitations](#known-limitations). |
| `python` | `3.14-bookworm` | |
| `mongo` | `7.0` | Not `8.0`: see [Known limitations](#known-limitations). |
| `semgrep/semgrep` | `1.184.0` | |
| `golang` | `1.27-bookworm` | |

`espressif/idf` was also requested but is **not** cached on any Ubuntu version; see
[Known limitations](#known-limitations).

All tags above publish both `linux/amd64` and `linux/arm64` manifests, so the same nine-image
list applies unchanged to every supported Ubuntu version and architecture.

## Selection criteria

The 10 repositories come from the tool-request issue linked in the pull request that introduced
this list; that request specified repositories only, not tags or versions. Nine of the ten are
cached (`espressif/idf` is excluded, see [Known limitations](#known-limitations)). Each tag was
chosen as the current stable release of its repository at implementation time (for example, the
latest published major/minor version as of this writing), following the same
[tool request process](../CONTRIBUTING.md#adding-a-new-tool-to-an-image) used for any other tool
addition. Tags aren't digest-pinned (see [Update policy](#update-policy)), so this list reflects a
point-in-time choice rather than a permanently fixed set of exact image contents.

## Update policy

- Images are pulled fresh on every weekly image build, so a pinned tag is refreshed automatically
  whenever its upstream digest changes (for example, security patches to a `*-bookworm` base).
- Tags are intentionally pinned to a specific version/variant rather than `latest`, so the cached
  *version* set stays the same from build to build. This does not make the cache byte-for-byte
  reproducible: since tags aren't pinned by digest, the underlying image content for a given tag
  can still change whenever its publisher republishes it.
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
Pester suite that runs after the pull step. The toolset's `docker.images` list is the single
source of truth for which images and tags are cached; the test file only maps each image's
*repository* (not its tag) to a validation command, so bumping a pinned tag never requires a
change to the test file. For every entry in `docker.images` the suite:

1. Confirms the image is present locally (`docker images` lists it).
2. Runs the image with `--pull=never` and a lightweight, non-mutating command (for example
   `--version`, `node --version`, or `go version`) to prove it can actually execute, not just
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
- **`espressif/idf` is not cached on any Ubuntu version.** It was part of the original request
  (~5.4 GB compressed per architecture, by far the largest of the ten images), but real builds
  measured insufficient disk headroom to include it safely: an Ubuntu 26.04 build with all 10
  images cached left only 16 GB free against the 17 GB minimum enforced by the `Disk free space`
  baseline test (see [`System.Tests.ps1`](../images/ubuntu/scripts/tests/System.Tests.ps1)), and a
  separate Ubuntu 22.04 build with the same 10 images ran out of disk space outright while
  extracting a later image's layers. Since the shortfall wasn't confined to one Ubuntu version,
  `espressif/idf` is excluded from every Ubuntu toolset rather than patched per OS. Revisit this
  exclusion if the Ubuntu base images' disk usage shrinks, the OS disk is resized, or the other
  nine images' combined footprint is reduced.
- **x64 OS disk bumped from 75 GB to 85 GB.** Even without `espressif/idf`, the remaining nine
  images (roughly 2.5 GB compressed combined) still didn't reliably fit: a cache-free main-branch
  build of Ubuntu 22.04 x64 measured only 18 GB free (just ~1 GB above the 17 GB minimum), and
  builds with the nine-image cache measured as low as 11-12 GB free on all three x64 Ubuntu
  versions. arm64 builds, by contrast, measured 23+ GB free with the full ten-image cache, so only
  the three x64 variants' `os_disk_size_gb` were increased, in
  [`locals.ubuntu.pkr.hcl`](../images/ubuntu/templates/locals.ubuntu.pkr.hcl).
- **`mongo` is pinned to `7.0`, not `8.0`.** MongoDB 8.0+ aborts at startup on Linux kernel
  versions 6.19 up to (but not including) 7.0.14, due to a known TCMalloc/rseq incompatibility
  (see [MongoDB SERVER-121912](https://jira.mongodb.org/browse/SERVER-121912)). The hosted Ubuntu
  runner kernels currently fall in that affected range, so `mongo:8.0` fails the
  `CachedDockerImages` usability check outright (`mongod` refuses to start even for `--version`).
  MongoDB 7.0 doesn't carry the affected TCMalloc code path and isn't affected. Revisit this pin
  once the hosted runner kernel is upgraded past 7.0.14 or MongoDB ships a build that tolerates the
  affected kernel range.
