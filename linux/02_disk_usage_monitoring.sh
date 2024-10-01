#!/bin/bash

LOG_PATH='/home/aditya/log/disk_alert.log'
THRESHOLD=80

# Get the usage alert of /var, remove % and get the value
USAGE=$(df -h /var | awk '{print $5}' | sed 's/%//' | tail -n 1)

# Check if usage exceeds the threshold
if [ "$USAGE" -gt "$THRESHOLD" ]; then
	echo "WARNING: /var disk usage if $USAGE" > $LOG_PATH
else
	echo "Disk usage is $USAGE. No issues detected" > $LOG_PATH
fi
