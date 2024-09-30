#!/bin/bash

# Script to compress and backup directory to s3 bucket 

DIRECTORY_TO_BACKUP="/home/aditya/files/*"
BUCKET_NAME="aditya-nakadi-bucket"
BACKUP_NAME="backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"
TMP_DIR="/home/aditya/tmp"

# Create a tar.gz archive of DIRECTORY_TO_BACKUP
echo 'Compressing the directory $DIRECTORY_TO_BACKUP...'
tar -cvzf $TMP_DIR/$BACKUP_NAME $DIRECTORY_TO_BACKUP

# Check if archive was successful
if [ $? -eq 0 ]; then
	echo 'Compression successful $TMP_DIR/$BACKUP_NAME'
else
	echo 'Compression failed... Exiting'
	exit 1
fi

# Upload to S3 bucket
echo 'Uploading $BACKUP_NAME to S3 bucket $BUCKET_NAME'
aws s3 cp $TMP_DIR/$BACKUP_NAME s3://$BUCKET_NAME/backups/$BACKUP_NAME

# Check if backup was successful
if [ $? -eq 0 ]; then
        echo 'Backup successful $TMP_DIR/$BACKUP_NAME'
else
        echo 'Backup failed... Exiting'
        exit 1
fi

# Clean up temp files
echo 'Cleaning up temporary files'
rm -f $TMP_DIR/$BACKUP_NAME

echo 'Backup completed successfully!'

# List all S3 backups
echo 'Listing all S3 backups:'
aws s3 ls s3://$BUCKET_NAME/backups/
