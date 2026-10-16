# Built-image workflow smoke tests

The reusable build workflow runs these tests after collecting Packer's image
reports, before archive export. Tests cover Ubuntu LXD containers, LXD VMs and Docker
images. Windows runtime tests are deferred.

`test_image_workflow.py` launches a disposable instance, copies this small
fixture and a checksum-verified act binary into it, and executes act in host
mode as `packer`. This makes workflow steps run inside the actual built image.
The published image is not modified by installing the test harness.

The workflow checks the unprivileged account and sudo access, performs a public
repository checkout with `actions/checkout`, runs a local JavaScript action and
checks its output, creates a Python virtual environment, and compiles/tests a
small CMake project. Failures block subsequent export and packaging.

Docker image IDs come from the Packer manifest's latest run, matched by builder
type and image OS. LXD uses the builder's image alias and explicitly selects
VMs when needed. The helper removes its own test instance on success, failure,
timeout or termination; it does not remove the built image. The workflow saves
the runtime log and JUnit XML result. The helper's `--junit-output` option records
one aggregate test case for the complete smoke workflow, including setup and
cleanup. Failures retain their exception type and message, and the helper keeps
its failing exit status. A separate action step reads this result and appends
the GitHub Actions run summary; the helper does not write CI-specific summaries.

A read-only `GITHUB_TOKEN` is required for the checkout action. It is copied
only into the disposable instance, through a temporary secrets file, and is
removed with that instance. No runner registration or registry publication is
performed. These act checks exercise workflows locally; real GitHub runner
integration and the separate OCI integrity checks have their own scope.
