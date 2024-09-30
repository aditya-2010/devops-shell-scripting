#!/bin/bash

# Extract the archive
tar -xvf /home/aditya/tmp/archive.tar.gz -C /home/aditya/tmp/logs

# Find top 5 IP addresses with 5xx status codes excluding 127.0.0.1
grep '5[0-9][0-9]' /home/aditya/tmp/logs/*.log | \
	grep -v '127.0.0.1' | \
	head -n 3 | \
	awk '{print $3}' > /tmp/report.log
