#!/bin/bash
java -Xms1G -Xmx4G -XX:MaxPermSize=128m -jar "TekkitLegendsWithPlugins.jar" nogui &

while :
do
	sleep 1
done
