#!/bin/bash
JAVA="/mmoneyhome/eig/jdk1.8.0_102/bin/jmap"
#daily=`date | cut -d ' ' -f 3`
#echo $daily
#month=`date | cut -d ' ' -f 2`
DATE=`date '+%Y%m%d-%H%M%S'`
/usr/sbin/ss --summary > /mmoneyvar/dumps/summary_$DATE.log 2>&1
top -n 1 -b > /mmoneyvar/dumps/top_$DATE.log 2>&1

process=`ps -eaf | grep java | grep -v grep | awk '/muleTomcat-EIG/ {print $2}'`

$JAVA -dump:live,format=b,file="/mmoneyvar/dumps/heap_web_$DATE.bin" $process

$JAVA -histo:live $process > "/mmoneyvar/dumps/jmap_histo_$DATE.log"

$JAVA -heap $process > "/mmoneyvar/dumps/jmap_heap_$DATE.log"

$JAVA -clstats $process > "/mmoneyvar/dumps/jmap_clsstats_$DATE.log"