#!/usr/bin/env bash
set -euo pipefail

PKI_ROOT="${PKI_ROOT:-$HOME/.local/share/jenkins-docker-pki}"

CA="${PKI_ROOT}/ca/ca.pem"
SERVER="${PKI_ROOT}/issued/workers/jenkins-workers/server-cert.pem"
CLIENT="${PKI_ROOT}/issued/controllers/jenkins-controller/cert.pem"

echo "Verifying worker certificate..."
openssl verify \
    -CAfile "${CA}" \
    "${SERVER}"

echo

echo "Verifying controller certificate..."
openssl verify \
    -CAfile "${CA}" \
    "${CLIENT}"

echo

echo "Worker certificate:"
openssl x509 \
    -in "${SERVER}" \
    -noout \
    -subject \
    -issuer \
    -dates \
    -ext subjectAltName

echo

echo "Controller certificate:"
openssl x509 \
    -in "${CLIENT}" \
    -noout \
    -subject \
    -issuer \
    -dates \
    -ext extendedKeyUsage
