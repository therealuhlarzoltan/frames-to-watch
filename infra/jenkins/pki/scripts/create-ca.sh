#!/usr/bin/env bash
set -euo pipefail

PKI_ROOT="${PKI_ROOT:-$HOME/.local/share/jenkins-docker-pki}"
CA_DIR="${PKI_ROOT}/ca"

umask 077

mkdir -p "${CA_DIR}"

if [[ -e "${CA_DIR}/ca-key.pem" ]]; then
    echo "ERROR: CA already exists at ${CA_DIR}"
    exit 1
fi

echo "Creating Docker/Jenkins CA..."

openssl genrsa \
    -aes256 \
    -out "${CA_DIR}/ca-key.pem" \
    4096

openssl req \
    -new \
    -x509 \
    -days 3650 \
    -sha256 \
    -key "${CA_DIR}/ca-key.pem" \
    -out "${CA_DIR}/ca.pem" \
    -subj "/CN=jenkins-docker-ca"

chmod 0400 "${CA_DIR}/ca-key.pem"
chmod 0444 "${CA_DIR}/ca.pem"

echo
echo "CA created:"
echo "  ${CA_DIR}/ca.pem"
echo
echo "PRIVATE KEY:"
echo "  ${CA_DIR}/ca-key.pem"
echo
echo "Protect the CA private key."
