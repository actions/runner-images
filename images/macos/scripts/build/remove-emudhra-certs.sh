#!/bin/bash -e -o pipefail
################################################################################
##  File:  remove-emudhra-certs.sh
##  Desc:  Remove eMudhra-related roots from the system certificate bundle
################################################################################

source ~/utils/utils.sh

# Remediation guidance: https://support.apple.com/en-us/149555
bundle=${1:-/etc/ssl/cert.pem}
temporary=$(mktemp)
trap 'rm -f "$temporary"' EXIT

# Remove both `emSign ECC Root CA - G3` and `AAA Certificate Services`.
# Each === or ### heading starts a section - skip a section until the next heading.
awk \
  -v emsign='=== /C=IN/OU=emSign PKI/O=eMudhra Technologies Limited/CN=emSign ECC Root CA - G3' \
  -v aaa='=== /C=GB/ST=Greater Manchester/L=Salford/O=Comodo CA Limited/CN=AAA Certificate Services' \
  '/^(===|###) /{skip=0} $0==emsign || $0==aaa{skip=1} !skip' \
  "$bundle" >"$temporary"

# Check the replacement before changing the original: it must contain parseable
# certificates, and neither targeted root should remain.
if [ ! -s "$temporary" ]; then
  echo "Replacement certificate bundle is empty" >&2
  exit 1
fi
if ! subjects=$(openssl crl2pkcs7 -nocrl -certfile "$temporary" | openssl pkcs7 -print_certs -noout); then
  echo "OpenSSL failed to parse the replacement certificate bundle" >&2
  exit 1
fi
if [ -z "$subjects" ]; then
  echo "OpenSSL returned no certificate information for the replacement bundle" >&2
  exit 1
fi
case "$subjects" in
  *'emSign ECC Root CA - G3'* | *'AAA Certificate Services'*)
    echo "Target root certificates remain in the replacement bundle" >&2
    exit 1
    ;;
esac

# Preserve the first backup - it is needed for tests
[ -e "$bundle.orig" ] || sudo -n cp -p "$bundle" "$bundle.orig"

# Replace the bundle when its contents have changed
if ! cmp -s "$bundle" "$temporary"; then
  sudo -n install -m 0644 -o root -g wheel "$temporary" "$bundle"
fi

CERTIFICATE_BUNDLE_PATH="$bundle" invoke_tests "Certificates"
