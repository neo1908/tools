#!/bin/bash

FILENAME_BASE=$(whoami)-jitsi-client

generate_p12()
{
    pushd jitsi_certs > /dev/null
    openssl pkcs12 -export -out ${FILENAME_BASE}.p12 -inkey ${FILENAME_BASE}.key -in ${FILENAME_BASE}.crt.pem
    popd
}
