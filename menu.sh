#!/bin/bash
# v1.0

DIRECTORY="$(cd "$(dirname "$0")" && pwd)"
cd "$DIRECTORY" || exit

source ./env.sh

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Build docker and deploy docker-compose   "
TITLE="Build and deploy : : $SERVICE"
MENU="Choose one of the following options:"

OPTIONS=(1 "Build"
         2 "Undeploy"
         3 "Deploy")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear



case $CHOICE in
        1)  ./build.sh
            ;;
        2)  source ./env.sh
            docker stack remove  "$SERVICE"
            ;;
        3)  source ./env.sh
            docker stack deploy --compose-file docker-compose.yml "$SERVICE"
            ;;
esac