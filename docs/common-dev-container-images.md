# Common development container images on Ubuntu images

To save users from pulling frequently used development and test container images at job time,
every Packer-built Ubuntu VM image (22.04, 24.04, and 26.04, both x64 and arm64) pre-pulls a
fixed set of container images during the build. The list is declared in the `docker.images`
array of each image's `toolsets/toolset-*.json` file and pulled by
[`install-docker.sh`](../images/ubuntu/scripts/build/install-docker.sh). All 10 requested images
are cached, including the large `espressif/idf` image — see
[Known limitations](#known-limitations) for the disk-size trade-off that required.

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
| `postgres` | `18` | Latest major release at implementation time. |
| `mysql` | `8.4` | Oracle's current MySQL Long-Term Support (LTS) release line. |
| `node` | `24-bookworm` | Current Active LTS release line (Node.js promotes an even-numbered major to LTS each October); only this exact tag is cached, `node:latest` and other Node major versions are not. |
| `pgvector/pgvector` | `pg18` | Must track the PostgreSQL major version above. |
| `localstack/localstack` | `2026.10.6` | LocalStack uses calendar versioning (`YYYY.MM.patch`) rather than semantic major/minor releases, so this tag is simply the latest published release at implementation time. Requires a `LOCALSTACK_AUTH_TOKEN` to activate; see [Known limitations](#known-limitations). |
| `python` | `3.14-bookworm` | Latest stable CPython release at implementation time (CPython has no separate LTS track). |
| `espressif/idf` | `v5.5.6` | Latest stable ESP-IDF release branch at implementation time. Large image (~5.4 GB compressed per architecture); required a larger OS disk on every Ubuntu version, see [Known limitations](#known-limitations). |
| `mongo` | `7.0` | Not the latest major (`8.0`): see [Known limitations](#known-limitations) for why. |
| `semgrep/semgrep` | `1.184.0` | Semgrep has no LTS track; this is simply the latest published release at implementation time. |
| `golang` | `1.27-bookworm` | Latest stable Go release at implementation time (Go has no separate LTS track; each release is supported until the next two releases ship). |

All tags above publish both `linux/amd64` and `linux/arm64` manifests, so the same ten-image
list applies unchanged to every supported Ubuntu version and architecture.

## Selection criteria

The 10 repositories come from the tool-request issue linked in the pull request that introduced
this list; that request specified repositories only, not tags or versions. Two patterns were used
to pick each tag, per the [tool request process](../CONTRIBUTING.md#adding-a-new-tool-to-an-image)
used for any other tool addition:

- **Projects with a formal LTS/stable track** (`mysql`, `node`) are pinned to that track's current
  release, since that's the version most users running these images would reach for.
- **Everything else** is pinned to the latest stable release published at implementation time
  (see the Notes column above for each repository's specific release model — major-version
  cadence, calendar versioning, or no LTS concept at all).

The one deliberate exception is `mongo`, pinned to `7.0` instead of the latest `8.0` for a
documented compatibility reason (see [Known limitations](#known-limitations)), not because `7.0`
was "latest" at the time.

Tags aren't digest-pinned (see [Update policy](#update-policy)), so this list reflects a
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
- **`espressif/idf` required bumping every Ubuntu version's OS disk.** It's by far the largest
  of the ten images (~5.4 GB compressed per architecture), and including it in the cache
  consistently broke the existing `Disk free space` baseline test's 17 GB minimum (see
  [`System.Tests.ps1`](../images/ubuntu/scripts/tests/System.Tests.ps1)) across every Ubuntu
  version: a cache-free main-branch build of Ubuntu 22.04 x64 measured only 18 GB free (~1 GB of
  pre-existing margin) before this PR, builds with the nine-*other*-image cache measured as low
  as 11-12 GB free on x64, and an Ubuntu 26.04 arm64 build with the full ten-image cache measured
  only 16 GB free. To fit it safely, `os_disk_size_gb` in
  [`locals.ubuntu.pkr.hcl`](../images/ubuntu/templates/locals.ubuntu.pkr.hcl) was increased on
  every Ubuntu version: x64 from 75 GB to 100 GB (x64 had almost no pre-existing headroom even
  without this cache), and arm64 from 75 GB to 85 GB (arm64 had more baseline headroom, but still
  not enough once `espressif/idf` was included). Revisit these sizes if the Ubuntu base images'
  disk usage shrinks or the cached image set changes.
- **`mongo` is pinned to `7.0`, not `8.0`.** MongoDB 8.0+ aborts at startup on Linux kernel
  versions 6.19 up to (but not including) 7.0.14, due to a known TCMalloc/rseq incompatibility
  (see [MongoDB SERVER-121912](https://jira.mongodb.org/browse/SERVER-121912)). The hosted Ubuntu
  runner kernels currently fall in that affected range, so `mongo:8.0` fails the
  `CachedDockerImages` usability check outright (`mongod` refuses to start even for `--version`).
  MongoDB 7.0 doesn't carry the affected TCMalloc code path and isn't affected. Revisit this pin
  once the hosted runner kernel is upgraded past 7.0.14 or MongoDB ships a build that tolerates the
  affected kernel range.
