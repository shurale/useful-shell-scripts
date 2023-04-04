#!/bin/bash


logdir=~/logs
log=$logdir/`basename $0`.`date +%F`.log

mkdir -p $logdir
echo "$0 [$$] Begin `date`">>$log

dat=`date +%F_%R`
url=example.com

# Delay first minutes after boot
uptime|grep -q 'up . min' && sleep 30

wget -S -O- $url/$dat.html >> $log 2>&1

echo "$0 [$$] End `date`">>$log
