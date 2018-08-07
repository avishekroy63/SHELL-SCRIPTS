#!/bin/bash
daily=`date | cut -d ' ' -f 3`
hour=`date | cut -d ' ' -f 4 | cut -d ':' -f1`
#echo "Capturing Netstat"
netstat -anp > /mmoneyvar/dumps/netstat_$daily$hour.log && date >> /mmoneyvar/dumps/netstat_$daily$hour.log 2>&1
netstat -s >> /mmoneyvar/dumps/netstat_$daily$hour.log && date >> /mmoneyvar/dumps/netstat_$daily$hour.log 2>&1
process=`ps -eaf | grep java | grep -v grep | awk '/muleTomcat_3.8-EIG/ {print $2}'`
echo $process

lsof -n -P -p $process > /mmoneyvar/dumps/lsof_$daily$hour.log && date >> /mmoneyvar/dumps/lsof_$daily$hour.log 2>&1

nstat >> /mmoneyvar/dumps/nstat_$daily$hour.log && date >> /mmoneyvar/dumps/nstat_$daily$hour.log 2>&1
