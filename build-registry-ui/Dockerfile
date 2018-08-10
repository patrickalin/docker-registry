###############################################
# Registry UI
###############################################
ARG REGISTRY_FROM
ARG IMAGE_FROM
ARG TAG_FROM

FROM $REGISTRY_FROM$IMAGE_FROM:$TAG_FROM

LABEL from.registry=$REGISTRY_FROM
LABEL from.image=$IMAGE_FROM
LABEL from.tag=$TAG_FROM

COPY files/localtime /etc/localtime

# --interval=60s --timeout=60s --retries=5 CMD curl -f http://localhost:8000/ || exit 1