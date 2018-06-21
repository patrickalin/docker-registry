FROM konradkleine/docker-registry-frontend:v2
COPY localtime /etc/localtime
COPY curl_7.38.0-4+deb8u11_amd64.deb /curl_7.38.0-4+deb8u11_amd64.deb
COPY zlib1g_1.2.8.dfsg-2+b1_amd64.deb /zlib1g_1.2.8.dfsg-2+b1_amd64.deb
COPY libc6-udeb_2.19-18+deb8u10_amd64.udeb /libc6-udeb_2.19-18+deb8u10_amd64.udeb
COPY libcurl3_7.38.0-4+deb8u11_amd64.deb /libcurl3_7.38.0-4+deb8u11_amd64.deb
COPY libidn11_1.29-1+deb8u2_amd64.deb /libidn11_1.29-1+deb8u2_amd64.deb
COPY librtmp1_2.4+20150115.gita107cef-1+deb8u1_amd64.deb /librtmp1_2.4+20150115.gita107cef-1+deb8u1_amd64.deb
COPY libssh2-1_1.4.3-4.1+deb8u1_amd64.deb /libssh2-1_1.4.3-4.1+deb8u1_amd64.deb
RUN dpkg -i libssh2-1_1.4.3-4.1+deb8u1_amd64.deb librtmp1_2.4+20150115.gita107cef-1+deb8u1_amd64.deb libidn11_1.29-1+deb8u2_amd64.deb libcurl3_7.38.0-4+deb8u11_amd64.deb curl_7.38.0-4+deb8u11_amd64.deb
HEALTHCHECK --interval=60s --timeout=60s --retries=5 CMD curl -f http://localhost:80/ || exit 1
