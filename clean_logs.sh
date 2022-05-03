#!/bin/bash
#
# Clean $logdir from old files
# May run hourly - it check last run date and abort if it is newer than 1 day ago 
# 

logdir=~/logs
log=$logdir/`basename $0`.`date +%F`.log
logflag=clean_files.flag
freedays=2 # Days of keeping uncompressed (free) logs in day
days=30 # Days of keepent logs


mkdir -p $logdir
echo "$0 [$$] Begin `date`">>$log

flag=`find $logdir -name $logflag -mtime -1`

if [ -n "$flag" ]
then
	echo "$0 [$$] Abort `date`">>$log
	exit
fi

echo "$0 [$$] Begin `date`">$logdir/$logflag

tmp=`mktemp`
if [ -f "$tmp" ]
then
        echo "Find files" >> $log
        find $LOGDIR -name '*.log' -mtime +$freedays > $tmp
        find $LOGDIR -name '*.txt' -mtime +$freedays >> $tmp
        wc -l $tmp >>$log
        echo "Compress files" >> $log
        cat $tmp|xargs -I test gzip --best test >>$log 2>&1
        rm $tmp
        echo "Delete old archives" >> $log
        find $LOGDIR -name '*.log.gz' -mtime +$days -print -delete >>$log 2>&1
        find $LOGDIR -name '*.txt.gz' -mtime +$days -print -delete >>$log 2>&1
        echo "Delete empty dirs" >> $log
        find $LOGDIR -type d -empty -mtime +$days -print -delete >>$log 2>&1
else
        echo "Error: cant create $tmp temporary file"
fi


echo "$0 [$$] End `date`">>$logdir/$logflag
echo "$0 [$$] End `date`">>$log

