#cd ABSOLUTE_PATHE_OF_CRONJOB
cd /mmoneyvar/dumps

NOWDATE=$(date +"%F")
LOG_FILE_NAME2="daily/jstat-gc-$NOWDATE.log"
LOG_FILE_NAME3="daily/jstat-gcold-$NOWDATE.log"
process=`ps -eaf | grep java | grep -v grep | awk '/muleTomcat-EIG/ {print $2}'`
/mmoneyhome/eig/jdk1.8.0_102/bin/jstat -gc $process >> $LOG_FILE_NAME2
#echo "gcoldcapacity" >> $LOG_FILE_NAME
/mmoneyhome/eig/jdk1.8.0_102/bin/jstat -gcold $process >> $LOG_FILE_NAME3
cd