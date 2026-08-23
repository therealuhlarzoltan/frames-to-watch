#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <worker-name> <worker-ip>"
    exit 1
fi

WORKER_NAME="$1"
WORKER_IP="$2"

PKI_ROOT="${PKI_ROOT:-$HOME/.local/share/jenkins-docker-pki}"
CA_DIR="${PKI_ROOT}/ca"
OUT_DIR="${PKI_ROOT}/issued/workers/${WORKER_NAME}"

umask 077

mkdir -p "${OUT_DIR}"

if [[ ! -f "${CA_DIR}/ca.pem" || ! -f "${CA_DIR}/ca-key.pem" ]]; then
    echo "ERROR: CA not found in ${CA_DIR}"
    exit 1
fi

if [[ -e "${OUT_DIR}/server-key.pem" ]]; then
    echo "ERROR: Certificate already exists for ${WORKER_NAME}"
    exit 1
fi

echo "Generating private key for ${WORKER_NAME}..."

openssl genrsa \
    -out "${OUT_DIR}/server-key.pem" \
    4096

openssl req \
    -new \
    -sha256 \
    -key "${OUT_DIR}/server-key.pem" \
    -out "${OUT_DIR}/server.csr" \
    -subj "/CN=${WORKER_NAME}"

cat > "${OUT_DIR}/server-ext.cnf" <<EOF
basicConstraints = critical,CA:FALSE
keyUsage = critical,digitalSignature,keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = DNS:${WORKER_NAME},IP:${WORKER_IP}
EOF

echo "Signing certificate with Jenkins Docker CA..."

openssl x509 \
    -req \
    -days 825 \
    -sha256 \
    -in "${OUT_DIR}/server.csr" \
    -CA "${CA_DIR}/ca.pem" \
    -CAkey "${CA_DIR}/ca-key.pem" \
    -CAcreateserial \
    -out "${OUT_DIR}/server-cert.pem" \
    -extfile "${OUT_DIR}/server-ext.cnf"

rm -f \
    "${OUT_DIR}/server.csr" \
    "${OUT_DIR}/server-ext.cnf"

chmod 0400 "${OUT_DIR}/server-key.pem"
chmod 0444 "${OUT_DIR}/server-cert.pem"

echo
echo "Worker certificate generated:"
echo "  ${OUT_DIR}/server-cert.pem"
echo "  ${OUT_DIR}/server-key.pem"
echo
echo "Install on ${WORKER_NAME}:"
echo "  /etc/docker/tls/ca.pem"
echo "  /etc/docker/tls/server-cert.pem"
echo "  /etc/docker/tls/server-key.pem"
