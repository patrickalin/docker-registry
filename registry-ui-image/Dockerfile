FROM snagles/docker-registry-manager
COPY localtime /etc/localtime
COPY libcurl-7.60.0-r1.apk /libcurl-7.60.0-r1.apk
COPY curl-7.60.0-r1.apk /curl-7.60.0-r1.apk
COPY libssh2-1.8.0-r2.apk /libssh2-1.8.0-r2.apk
RUN apk add --allow-untrusted /libssh2-1.8.0-r2.apk /libcurl-7.60.0-r1.apk /curl-7.60.0-r1.apk
HEALTHCHECK --interval=60s --timeout=60s --retries=5 CMD curl -f http://localhost:8080/ || exit 1
