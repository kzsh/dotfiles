#!/bin/bash
DIRECTORY="$1"
S3_BUCKET="$2"
"$COMMON_SCRIPTS/bash/s3-sync-files.sh" "$DIRECTORY" "s3://$S3_BUCKET/${DIRECTORY#'/'}"
