# Set the name of the local user that will have the key mapped to
USERNAME="gecloud"
HOST="localhost"

cat > openssl.conf << EOL
distinguished_name = req_distinguished_name
[req_distinguished_name]
[v3_req_client]
extendedKeyUsage = clientAuth
subjectAltName = otherName:1.3.6.1.4.1.311.20.2.3;UTF8:$USERNAME@$HOST
EOL

export OPENSSL_CONF=openssl.conf
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -out $USERNAME-$HOST-cert.pem -outform PEM -keyout $USERNAME-$HOST-cert_key.pem -subj "/CN=$USERNAME" -extensions v3_req_client
rm openssl.conf
