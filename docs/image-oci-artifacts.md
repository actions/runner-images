# Standalone image-to-OCI commands

Keep each executable with `oci_image.py` in the same directory. They require
Python 3.10 or later, run from any working directory, and have no dependency on
runner-images, Packer, GitHub Actions, or an image-type naming convention. They
write a new local OCI image layout; they do not upload, delete source images,
register runners, or write CI outputs or summaries.

All commands accept `--output-directory`, `--reference` (default `image`), and
repeatable `--annotation KEY=VALUE` arguments. Output directories must not exist.
Failed conversions remove their temporary workspaces without publishing an index.
The output layout still needs space proportional to the exported image size.

## LXD container to runnable OCI image

```sh
helpers/lxd-image-to-oci --image my-container --architecture amd64 \
  --output-directory /storage/container-oci --layer-size 1073741824
```

`--image` accepts a local alias or full fingerprint. `--socket` and `--project`
select the daemon socket and project. Socket discovery checks `LXD_SOCKET`,
`LXD_DIR`, then the snap and distribution socket locations. Export streams are
checked against the source fingerprint before the final layout is published.
Alternatively, use `--export-directory DIR` for an existing unified archive or
split metadata/rootfs export. No running instance is needed.

The rootfs becomes standard, uncompressed OCI filesystem tar layers. Unified
exports lose the `rootfs/` prefix; metadata and templates do not become rootfs
files. Container metadata is retained as a base64 tar archive in the runtime
label `org.linuxcontainers.image.metadata` (8 MiB archive limit). Split metadata
archives retain their original encoding; unified metadata is repacked with tar
member attributes and contents preserved. Templates are retained, not executed.

Use `--config runtime.json` to supply an OCI runtime config object containing
`User`, `Env`, `WorkingDir`, `Entrypoint`, `Cmd`, labels, and other standard fields.
The default command is `/bin/sh`, running as root. Architecture is explicit and
is not inferred from a repository-specific name. The converter supports tar,
gzip, xz and bzip2 inputs; zstd tar input requires Python 3.14 or later.

Unified tar exports stream directly into final layers. SquashFS requires the
`sqfs2tar` executable from `squashfs-tools-ng` and a seekable input: its compressed
rootfs is staged temporarily, converted without extracting a rootfs tree, then
removed. Budget for that compressed input alongside the final layers. CI uses
uncompressed unified LXD exports and avoids this fallback.

## LXD VM to OCI artifact

```sh
helpers/lxd-vm-image-to-oci --image my-vm --architecture arm64 \
  --output-directory /storage/vm-oci --chunk-size 1073741824
```

Source, socket, project and offline-export arguments match the container command.
`--os` defaults to `linux`. The command preserves the complete qcow2 disk and
metadata archive, including templates. Unified VM tar streams are separated into
disk chunks and a metadata tarball without assembling another qcow2 file.
It does not flatten, boot, mount, or assume a single partition in the disk.

The VM manifest uses artifact type `application/vnd.lxd.image.vm.v1` and config
media type `application/vnd.lxd.image.vm.config.v1+json`. These are this tool's
custom contract, not standard OCI runnable-image media types. The config contains
`schemaVersion: 1`, `os`, `architecture`, `chunkSize`, and `files`. Each file records
its name, role (`metadata` or `disk`), format (`tar` or `qcow2`), compression,
logical size, whole-file SHA-256 digest and ordered layer indices. Descriptor
sizes and digests identify individual chunks. Payload media types are
`application/vnd.lxd.image.<role>.<format>.chunk.v1[+<compression>]`.

Chunk sizes range from 1 byte to 1 GiB. Original compression is retained without
adding another compression pass. Local VM blobs retain sparse zero blocks;
registry sizes and hashes cover their complete logical bytes. A downloader must
verify descriptors, reconstruct each file in layer order, and verify its final
size and digest before importing or booting it. VM artifacts are retrieved with
ORAS, not `docker pull`.

## Docker image to runnable OCI image

```sh
helpers/docker-image-to-oci --image my-image:local \
  --output-directory /storage/docker-oci --layer-size 1073741824
```

Requires the Docker CLI and access to its daemon. The command inspects the local
image and pins its full ID. For Linux it creates a container without starting it
and streams `docker container export` directly into OCI layers. The temporary
container and its anonymous volumes are removed on both success and failure.
This avoids the classic Docker image store's full layer staging during
`docker image save`; the source image and final OCI layout still coexist.

The merged Linux filesystem is flattened and split at tar-entry boundaries.
Original layer history is replaced with records matching the generated layers.
Runtime config and platform fields, including user, command, environment, labels,
working directory and architecture variant, come from the original image rather
than the export container. Ownership, modes, symlinks, hardlinks and PAX xattrs
are retained. During streaming, `/etc/hosts` and `/etc/resolv.conf` become empty
regular files, `/etc/hostname` regains its original bytes, and `/.dockerenv` is
omitted. The three files retain their original ownership, modes and timestamps;
other Docker initialization placeholders remain.

Reading the original files requires Docker BuildKit through the default local
builder. A scratch stage uses only `COPY` to export these three files from the
image, without running its commands or exporting its complete filesystem. The
source must provide all three as regular files, each no larger than 8 MiB.
The converter retains an `oci-export-source:<image-ID>` tag for this immutable
local source, because removing the last tag of an originally untagged image can
delete it. Source images are retained on both success and failure.

Windows keeps the `docker image save` path, accepting legacy and OCI-backed
archives and preserving its runtime config and Windows OS version.
Windows layers are preserved exactly when within the size limit. Oversized
Windows layers fail explicitly; splitting their platform-specific state needs
Windows validation. Windows conversion cannot be tested on the local Linux host.

`--layer-size` bounds complete tar layers, including headers and end padding.
It defaults to 1 GiB and must be at least 10240 bytes. An individual entry that
cannot fit fails with its name and guidance to increase the limit. Arbitrary
byte splitting cannot produce a runnable filesystem layer. Filesystems with
large hardlink groups and runtime layer-count limits also need consideration
when selecting a small layer size. Hardlink groups are co-located in a layer;
the converter can re-emit a target from an existing blob without extracting a
rootfs tree. A whole group that cannot fit fails explicitly.

The two container commands produce standard OCI image config, layer descriptors,
and matching uncompressed diffIDs. Their manifests have no custom artifact type.
After copying the layout to a registry, ordinary `docker pull` and `docker run`
work without a reassembly helper:

```sh
skopeo copy oci:/storage/container-oci:image docker://ghcr.io/OWNER/IMAGE:TAG
docker pull ghcr.io/OWNER/IMAGE:TAG
```

The conversion commands themselves never publish, including in PR runs.
