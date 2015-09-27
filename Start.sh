#!/bin/bash
screen -dmS minecraft "cd /data &&./ServerStart.sh"
for (( ; ; ))
do
   sleep 1
done
