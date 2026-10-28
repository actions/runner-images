#!/bin/bash
set -euo pipefail
################################################################################
##  File: remove-emudhra-certs.sh
##  Desc: Follow Apple's steps to remove compromised eMudhra CA roots
################################################################################

# https://support.apple.com/en-us/149555

# 1. Back up the bundle, keeping the original backup if it already exists.
[ -e /etc/ssl/cert.pem.orig ] || sudo cp -p /etc/ssl/cert.pem /etc/ssl/cert.pem.orig

# 2. Remove emSign ECC Root CA - G3.
t=$(mktemp)
awk -v s='=== /C=IN/OU=emSign PKI/O=eMudhra Technologies Limited/CN=emSign ECC Root CA - G3' \
    '/^(===|###) /{skip=0} $0==s{skip=1} !skip' /etc/ssl/cert.pem > "$t"
[ -s "$t" ]
sudo install -m 0644 -o root -g wheel "$t" /etc/ssl/cert.pem
rm -f "$t"

# 3. Remove AAA Certificate Services to block the cross-signed intermediates.
t=$(mktemp)
awk -v s='=== /C=GB/ST=Greater Manchester/L=Salford/O=Comodo CA Limited/CN=AAA Certificate Services' \
    '/^(===|###) /{skip=0} $0==s{skip=1} !skip' /etc/ssl/cert.pem > "$t"
[ -s "$t" ]
sudo install -m 0644 -o root -g wheel "$t" /etc/ssl/cert.pem
rm -f "$t"

# 4. Check the result; fail the image build if either root remains.
certificates=$(openssl crl2pkcs7 -nocrl -certfile /etc/ssl/cert.pem | openssl pkcs7 -print_certs -noout)
if affected_roots=$(grep -E 'emSign ECC Root CA - G3|AAA Certificate Services' <<< "$certificates"); then
    printf 'ERROR: affected CA roots remain in /etc/ssl/cert.pem:\n%s\n' "$affected_roots" >&2
    exit 1
fi
