#!/bin/bash

DB_HOST=${DB_HOST}
DB_USER=${DB_USER_NAME}
DB_PASS=${DB_PASSWORD}
DB_NAME=${DB_NAME}
AWS_BUCKET="bucket-codigo-backup"
AWS_FOLDER="guevara/database"

DATE=$(date +'%Y%m%d%H%M%S')
BACKUP_FILE="/tmp/${DB_NAME}_${DATE}.sql"

mysqldump -h $DB_HOST -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_FILE

aws s3 cp $BACKUP_FILE s3://$AWS_BUCKET/$AWS_FOLDER/$DATE/

rm $BACKUP_FILE