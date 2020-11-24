#!/bin/bash

FILENAME_BASE=$(whoami)-jitsi-client

generate_rsa_csr()
{
    echo "Generating RSA key..."
    echo "Choose key size ( 2048 / 4096 ):"

    read KEYSIZE

    if [[ $KEYSIZE -eq 2048 || $KEYSIZE -eq 4096 ]]
    then

        mkdir -p jitsi_certs > /dev/null
        pushd jitsi_certs > /dev/null
        openssl genrsa -aes256 -out ${FILENAME_BASE}.key ${KEYSIZE}

        openssl req -new -key ${FILENAME_BASE}.key -out ${FILENAME_BASE}.csr.pem \
            -subj "/C=GB/ST=England/O=RPI-INF/OU=Jitsi/CN=$(whoami) Jitsi Client"

        echo "Attach jitsi_certs/${FILENAME_BASE}.csr.pem to an email and send to Ben"

        popd
    else
        echo_help
    fi
}

echo_help()
{
    cat << EOF
Options are:
    rsa - Generate a CSR using an RSA key ( key size will be prompted 2049 / 4096 )
    ecdsa - Generate a CSR using an ECDSA key ( will try to use secp521r1, if not available will prompt )
EOF
}


generate_rsa_csr
