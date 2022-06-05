#!/bin/bash

# Color
readonly _GREEN="\033[0;32m";
readonly _YELLOW="\033[0;33m";
readonly _RED="\033[0;31m";
readonly _NOCOLOR="\033[0m";
readonly _LIGHTGRAY="\033[0;37m";
readonly _DARKGRAY="\033[0;30m";
readonly _PURPLE="\033[0;35m";

#variables

NAME_STACK="xxxxxxx"
NAME_YML="xxxxxxx.yml"

# Command line

LIST_ID=`sudo docker service ls -q`
CONFIG_ID=`sudo docker config ls -q`

while true; do
clear	
echo "##############################################"
echo -e   "${_YELLOW}Docker swarm manager${_NOCOLOR}"
echo "##############################################"
echo ""
echo -e "[1] ${_RED}List all service.${_NOCOLOR}"
echo -e "[2] ${_RED}List all configs.${_NOCOLOR}"
echo -e "[3] ${_RED}Display a live stream of container.${_NOCOLOR}"
echo -e "[4] ${_RED}Remove all service.${_NOCOLOR}"
echo -e "[5] ${_RED}Remove all config.${_NOCOLOR}"
echo -e "[6] ${_RED}stack update${_NOCOLOR}"
echo -e "[7] ${_RED}Exit${_NOCOLOR}"
echo ""
echo -n "Choose an option: "
read option

if [[ "$option" != [0-7] ]]
then
	echo "invalid option"
	break
fi




case $option in
    1) LIST=`sudo docker service ls`
	   clear
	   echo "Listing services running docker swarm..."
	   echo ""
	   echo  "$LIST"
	   

        ;;

	2) LIST_CONFIG=`sudo docker config ls`
       clear
       echo "Listing settings in docker swarm..."
       echo ""
       echo  "$LIST_CONFIG"


        ;;


    3) STATS=`sudo docker stats --no-stream`
	   clear
	   echo "Showing statistics for all containers..."
	   echo ""
	   echo "$STATS"		

        ;;

    4) REMOVE_SERVICE=`sudo docker service rm $LIST_ID`
	   clear
	   echo "Removing all services.."
 	   echo "$REMOVE_SERVICE"
	
        ;;

	5) REMOVE_CONFIG=`sudo docker config rm $CONFIG_ID`
	   clear
	   echo "Removing all settings..."
       echo "$REMOVE_CONFIG"	   

        ;;

    6) UP=`cd /opt/fleet/ && sudo docker stack deploy -c $NAME_YML $NAME_STACK`
	   clear
	   echo "Deploy"
       echo "$UP"           

        ;;

        *) exit
        ;;
esac

echo ""
echo ""
echo -n -e "${_YELLOW}Do you want to return to the menu${_NOCOLOR} s/n: "
read menu


if [[ "$menu" == ['s-S'] ]]
then 
	echo "going back to options"
else
	echo "going out"
	break
fi

done

