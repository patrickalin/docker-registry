#!/bin/bash
# Version 1.0

RED='\033[1;31m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

function docker_tag_exists() {
    TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${REGISTRY_LOGIN}'", "password": "'${REGISTRY_PASSWORD}'"}' "https://'$1'/v2/users/login/")
    EXISTS=$(curl -s -H "Authorization: JWT ${TOKEN}" https://"$1"/v2/"$2"/tags/list)
    if [[ $EXISTS = *"$3"* ]]; then
        return 0
    fi
}

function line {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

function echoBlue {
    echo -e "$BLUE $1 $NC"
}

function echoGreen {
    echo -e "$GREEN $1 $NC"
}

function echoRed {
    echo -e "$RED $1 $NC"
}

function buildImage {
    set -e
    
    echoBlue "Test internet / proxy"
    status=$(curl -s -o /dev/null -w "%{http_code}" http://www.google.be)
    if [ "$status" != 200 ]; then echo "$status"; echoRed "$REGISTRY_FROM down"; exit 1;fi;
    echoGreen "Internet ok : $status"
    line
    
    echoBlue "Test registry From : $REGISTRY_FROM"
    if [ -n "$REGISTRY_FROM" ]
    then
        status=$(curl -s -o /dev/null -w "%{http_code}" http://"$REGISTRY_FROM")
        
        if [ "$status" != 200 ]; then echo "$status"; echoRed "$REGISTRY_FROM down"; exit 1;fi;
        echoGreen "$REGISTRY_FROM : $status"
    else
        echoGreen "Use Docker Hub"
    fi
    line
    
    echoBlue "Test registry To : $REGISTRY_TO"
    if [ -n "$REGISTRY_TO" ]
    then
        if [ $REGISTRY_TO != "local" ]
        then
            status=$(curl -s -o /dev/null -w "%{http_code}" http://"$REGISTRY_TO")
            
            if [ "$status" != 200 ]; then echo "$status"; echoRed "$REGISTRY_TO down"; exit 1;fi;
            echoGreen "$REGISTRY_TO : $status"
        fi
    else
        echoGreen "Use Docker Hub"
    fi
    line
    
    #################### END TEST CONNECTIVTY ####################
    
    FROM_FQDN="$REGISTRY_FROM${REGISTRY_FROM:+/}$IMAGE_FROM:$TAG_FROM"
    echoGreen "From : $FROM_FQDN"
    if [ $REGISTRY_TO != "local" ]
    then
        TO_FQDN="$REGISTRY_TO${REGISTRY_TO:+/}$IMAGE_TO:$TAG_TO"
    else
        TO_FQDN="local/$IMAGE_TO:$TAG_TO"
    fi
    echoGreen "To : $TO_FQDN"
    FROM_REGISTRY_FQDN="$REGISTRY_TO${REGISTRY_TO:+/}$IMAGE_FROM:$TAG_FROM"
    line
    
    if ! docker_tag_exists "$REGISTRY_TO" "$IMAGE_FROM" "$TAG_FROM"; then
        echoBlue "Image to pull :"; echoGreen "$FROM_FQDN"
        docker pull "$FROM_FQDN"
        line
        
        echoBlue "Tag Image :"; echoGreen "$FROM_FQDN"
        docker tag 	"$FROM_FQDN" 		"$FROM_REGISTRY_FQDN"
        line
        
        echoBlue "Push :"; echoGreen "$FROM_REGISTRY_FQDN"
        docker push 	"FROM_REGISTRY_FQDN"
        line
        
        docker rmi "$FROM_REGISTRY_FQDN"
    fi
    
    echoBlue "Build and push $FROM_FQDN to $TO_FQDN"
    docker build -t 	"$TO_FQDN" --build-arg REGISTRY_FROM="$REGISTRY_FROM" --build-arg IMAGE_FROM="$IMAGE_FROM" --build-arg TAG_FROM="$TAG_FROM" .
    if  [ "$REGISTRY_TO" != "local" ]
    then
        docker push 		"$TO_FQDN"
        echoBlue "Remove : image no more use";
        docker rmi "$TO_FQDN"
        docker rmi "$FROM_FQDN"
        line
    fi

    line
    
    echoBlue "List images"
    docker images | grep "$IMAGE_TO"
}