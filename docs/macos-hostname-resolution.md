# macOS hostname resolution

The macOS image assigns a unique hostname on each boot. `HostName` must use a
plain name rather than `.local`, which depends on multicast DNS. The boot script
maintains only its own marked IPv4 and IPv6 loopback aliases in `/etc/hosts`;
existing entries and the standard localhost mappings are retained.

`configure-hostname.sh` applies the boot script before image validation and
registers `Hostname.Tests.ps1`. The installed boot script also runs the bounded,
read-only resolver check on each new VM, logging results to
`/var/log/runner-hostname.log`. Each Python resolver call must succeed
in less than two seconds; a separate child-process watchdog bounds a stuck call.

A provisioning service can rename the VM after the image's boot script finishes.
Such a service must maintain the same resolvable-hostname contract and run the
check **after assigning the final hostname**, before accepting the runner:

```bash
python3 /usr/local/bin/check_hostname_resolution.py
```

This check does not repair or rename the machine. It tests `getaddrinfo` with
`AI_CANONNAME`, `getfqdn`, and `gethostbyaddr` against the current system hostname.
A successful image-build or earlier boot-time check does not establish that a
later provisioning-time rename is correct. Reverse lookups for unrelated network
interface addresses are outside this check's scope.

See [runner-images issue #14568](https://github.com/actions/runner-images/issues/14568).
