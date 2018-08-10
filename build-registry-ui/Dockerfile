###############################################
# Registry UI : alpine 3.7.4
###############################################
ARG REGISTRY_FROM
ARG IMAGE_FROM
ARG TAG_FROM

FROM $REGISTRY_FROM$IMAGE_FROM:$TAG_FROM

LABEL from.registry=$REGISTRY_FROM
LABEL from.image=$IMAGE_FROM
LABEL from.tag=$TAG_FROM

COPY files/localtime /etc/localtime
COPY files/apk/ /

USER root

RUN apk add --allow-untrusted /*.apk 

HEALTHCHECK --interval=30s --timeout=30s --retries=5 CMD curl -f http://localhost:8000/ || exit 1