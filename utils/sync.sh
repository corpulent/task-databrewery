#!/bin/bash

set -e

FILE_SYNC_SOURCE=$ENV_FILE_SYNC_SOURCE
FILE_SYNC_TARGET=$ENV_FILE_SYNC_TARGET
S3_BUCKET_NAME=$SYS_S3_BUCKET_NAME
ORG_ID=$SYS_ORG_ID

echo $AWS_ACCESS_KEY_ID
echo $AWS_SECRET_ACCESS_KEY

if [[ -z ${FILE_SYNC_SOURCE} || -z ${FILE_SYNC_TARGET} ]];
then
	echo 'File sync source or target is not set.'
  	exit 1
fi

echo "Syncing s3://${S3_BUCKET_NAME}/org-${ORG_ID}/code/${FILE_SYNC_SOURCE}" to "${FILE_SYNC_TARGET}"
aws s3 sync "s3://${S3_BUCKET_NAME}/org-${ORG_ID}/code/${FILE_SYNC_SOURCE}" "${FILE_SYNC_TARGET}"