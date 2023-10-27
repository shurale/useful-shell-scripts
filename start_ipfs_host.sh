#!/bin/bash
#
# Start IPFS host docker images
#

logdir=~/logs
log=$logdir/$(basename "$0").$(date +%F).log
delay=30
vardelay=300
image=ipfs_host

mkdir -p $logdir
echo "$0 [$$] Begin $(date)">>"$log"

# Wait random number of seconds
s=$((delay + (RANDOM % vardelay)))
echo "++ sleep $s" >> "$log"
sleep "$s"

echo "$0 [$$] $(date) start $image container">>"$log"
echo "++ docker start $image">>"$log"
docker start $image >>"$log" 2>&1
sleep 5
echo "++ docker logs --since 1h $image" >>"$log" 2>&1
docker logs --since 1h $image >>"$log" 2>&1

echo "$0 [$$] End $(date)">>"$log"
