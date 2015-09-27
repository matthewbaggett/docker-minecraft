#!/bin/bash
echo "Launching Minecraft in screen"
screen -dmS minecraft /data/ServerStart.sh
for (( ; ; ))
do
   sleep 1
done
