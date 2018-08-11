###############################################
# Registry
###############################################
ARG REGISTRY_FROM
ARG IMAGE_FROM
ARG TAG_FROM

FROM $REGISTRY_FROM$IMAGE_FROM:$TAG_FROM

LABEL from.registry=$REGISTRY_FROM
LABEL from.image=$IMAGE_FROM
LABEL from.tag=$TAG_FROM

COPY files/localtime /etc/localtime
COPY files/htpasswd/ auth/htpasswd
COPY files/config.yml /etc/docker/registry/config.yml
COPY files/apk/ /

RUN apk add --allow-untrusted /*.apk

HEALTHCHECK --interval=10s --timeout=10s --retries=3 CMD curl -f http://localhost:5000/ || exit 1
