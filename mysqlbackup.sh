#!/bin/bash

sqlfile=backup-file.sql
sqlbackup="--all-databases --user=root --password=1ie10NM1VijiVuHtWpUsfQpi"

keep_day=30

tmpdir=/tmp/mysqldumps/$(date +%Y%m%d)/
zipfile=$sqlfile.gz

mkdir -p $tmpdir

if mysqldump $sqlbackup > $sqlfile; then
    echo 'backup done!'

     # Check if tmp directory exists
    if [ -d $tmpdir ]; then
        echo "Directory '$tmpdir' created successfully."
    else
        echo "Failed to create directory '$tmpdir'."
    fi

        # Compress backup 
    if gzip -c $sqlfile > $zipfile; then
        echo 'The backup was successfully compressed'
    else
        echo 'Error compressing backupBackup was not created!' 
        exit
    fi
    rm $sqlfile 

else
    echo "backup failed (:"
fi

# Move/Delete old backups 
#find $backupfolder -mtime +$keep_day -delete
#mv $sqlfile $tmpdir
mv $zipfile $tmpdir



# Delete tables in a database

#DATABASE=sakila
#mysql -Nse 'show tables' sakila | \
#    while read table; do mysql \
#    -e "use sakila;SET FOREIGN_KEY_CHECKS=0;truncate table $table;SET FOREIGN_KEY_CHECKS=1;" ;done