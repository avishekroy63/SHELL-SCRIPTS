#!/bin/bash
#daily=`date | cut -d ' ' -f 3`
#hour=`date | cut -d ' ' -f 4 | cut -d ':' -f1`
DATE=`date '+%Y%m%d-%H%M%S'`
process=`ps -eaf | grep java | grep -v grep | awk '/muleTomcat-EIG/ {print $2}'`
#echo "Capturing Netstat"
/usr/sbin/nstat > /mmoneyvar/dumps/nstat_$DATE.log
/usr/sbin/lsof -n -P -p $process > /mmoneyvar/dumps/lsof_$DATE

netstat -anp > /mmoneyvar/dumps/netstat_$DATE.log
netstat -s >> /mmoneyvar/dumps/netstat_$DATE.log
#nstat > /mmoneyvar/dumps/nstat_$DATE.log 
#process=`ps -eaf | grep java | grep -v grep | awk '/muleTomcat_3.8-EIG/ {print $2}'`
#echo $process
#lsof -n -P -p $process > /mmoneyvar/dumps/lsof_$DATE
#nstat > /mmoneyvar/dumps/nstat_$DATE.log 2>&1