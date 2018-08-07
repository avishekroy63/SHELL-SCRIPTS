#!/bin/bash
JAVA="/usr/bin/jdk1.6.0_29/bin/jmap"
daily=`date | cut -d ' ' -f 3`
echo $daily
month=`date | cut -d ' ' -f 2`
ss --summary > /mmoneyvar/dumps/summary_$daily$month.log && date >> /mmoneyvar/dumps/summary_$daily$month.log 2>&1
#top -n 1 -b > /mmoneyvar/dumps/top_$daily$month.log && date >> /mmoneyvar/dumps/top_$daily$month.log 2>&1

#process=`ps -eaf | grep java | grep -v grep | awk '/muleTomcat_3.8-EIG/ {print $2}'`

#$JAVA -dump:live,format=b,file="/mmoneyvar/dumps/heap_web_$daily$month.bin" $process

#$JAVA -histo:live $process > "/mmoneyvar/dumps/jmap_histo_$daily$month.log"
