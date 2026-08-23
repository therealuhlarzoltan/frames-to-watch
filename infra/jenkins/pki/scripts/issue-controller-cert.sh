#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <controller-name>"
    exit 1
fi

CONTROLLER_NAME="$1"

PKI_ROOT="${PKI_ROOT:-$HOME/.local/share/jenkins-docker-pki}"
CA_DIR="${PKI_ROOT}/ca"
OUT_DIR="${PKI_ROOT}/issued/controllers/${CONTROLLER_NAME}"

umask 077

mkdir -p "${OUT_DIR}"

if [[ ! -f "${CA_DIR}/ca.pem" || ! -f "${CA_DIR}/ca-key.pem" ]]; then
    echo "ERROR: CA not found in ${CA_DIR}"
    exit 1
fi

if [[ -e "${OUT_DIR}/key.pem" ]]; then
    echo "ERROR: Certificate already exists for ${CONTROLLER_NAME}"
    exit 1
fi

echo "Generating client key..."

openssl genrsa \
    -out "${OUT_DIR}/key.pem" \
    4096

openssl req \
    -new \
    -sha256 \
    -key "${OUT_DIR}/key.pem" \
    -out "${OUT_DIR}/client.csr" \
    -subj "/CN=${CONTROLLER_NAME}"

cat > "${OUT_DIR}/client-ext.cnf" <<EOF
basicConstraints = critical,CA:FALSE
keyUsage = critical,digitalSignature,keyEncipherment
extendedKeyUsage = clientAuth
EOF

echo "Signing client certificate..."

openssl x509 \
    -req \
    -days 825 \
    -sha256 \
    -in "${OUT_DIR}/client.csr" \
    -CA "${CA_DIR}/ca.pem" \
    -CAkey "${CA_DIR}/ca-key.pem" \
    -CAcreateserial \
    -out "${OUT_DIR}/cert.pem" \
    -extfile "${OUT_DIR}/client-ext.cnf"

rm -f \
    "${OUT_DIR}/client.csr" \
    "${OUT_DIR}/client-ext.cnf"

chmod 0400 "${OUT_DIR}/key.pem"
chmod 0444 "${OUT_DIR}/cert.pem"

echo
echo "Jenkins controller certificate generated:"
echo "  ${OUT_DIR}/cert.pem"
echo "  ${OUT_DIR}/key.pem"
