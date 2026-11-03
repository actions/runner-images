#!/usr/bin/env python3
"""Read-only hostname resolver regression check for built and deployed macOS VMs."""

import argparse
import json
import subprocess
import sys

# Bound the resolver itself, with a separate process watchdog because system
# resolver calls cannot reliably be interrupted by a Python thread timeout.
LOOKUP_TIMEOUT = 2.0
PROCESS_TIMEOUT = LOOKUP_TIMEOUT + 3.0
LOOKUPS = ("getaddrinfo", "getfqdn", "gethostbyaddr")
WORKER = """
import json
import socket
import sys
import time

hostname = socket.gethostname()
lookup = sys.argv[1]
start = time.monotonic()
if lookup == "getaddrinfo":
    result = socket.getaddrinfo(
        hostname, None, socket.AF_UNSPEC, socket.SOCK_DGRAM,
        0, socket.AI_CANONNAME,
    )
elif lookup == "getfqdn":
    result = socket.getfqdn()
else:
    result = socket.gethostbyaddr(hostname)
elapsed = time.monotonic() - start
if not result:
    raise RuntimeError("Hostname resolution returned no result")
print(json.dumps({"lookup": lookup, "hostname": hostname,
                  "seconds": elapsed, "result": result}))
"""


def check_lookup(lookup):
    try:
        process = subprocess.run(
            [sys.executable, "-c", WORKER, lookup],
            capture_output=True,
            text=True,
            timeout=PROCESS_TIMEOUT,
            check=True,
        )
    except subprocess.TimeoutExpired as error:
        raise RuntimeError(
            f"{lookup}: resolver process exceeded {PROCESS_TIMEOUT:g}s"
        ) from error
    except subprocess.CalledProcessError as error:
        raise RuntimeError(f"{lookup}: resolution failed: {error.stderr.strip()}") from error
    result = json.loads(process.stdout)
    if result["seconds"] >= LOOKUP_TIMEOUT:
        raise RuntimeError(
            f"{lookup}: hostname {result['hostname']!r} took "
            f"{result['seconds']:.3f}s (limit {LOOKUP_TIMEOUT:g}s)"
        )
    print(json.dumps(result))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--lookup", choices=LOOKUPS)
    args = parser.parse_args()
    try:
        for lookup in (args.lookup,) if args.lookup else LOOKUPS:
            check_lookup(lookup)
    except (RuntimeError, OSError, ValueError) as error:
        print(error, file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
