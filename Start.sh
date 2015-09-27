#!/bin/bash
screen -dmS minecraft ./ServerStart.sh
for (( ; ; ))
do
   sleep 1
done
