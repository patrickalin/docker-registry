FROM registry:2.6.2
COPY localtime /etc/localtime
COPY certs/ /certs
COPY auth/ /auth
COPY config.yml /etc/docker/registry/config.yml
COPY libssh2-1.7.0-r0.apk /libssh2-1.7.0-r0.apk
COPY curl-7.59.0-r0.apk /curl-7.59.0-r0.apk
COPY libcurl-7.59.0-r0.apk /libcurl-7.59.0-r0.apk
RUN apk add --allow-untrusted /libssh2-1.7.0-r0.apk /libcurl-7.59.0-r0.apk /curl-7.59.0-r0.apk
HEALTHCHECK --interval=10s --timeout=10s --retries=3 CMD curl -f http://localhost:5000/ || exit 1
