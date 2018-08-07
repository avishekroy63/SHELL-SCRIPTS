#cd ABSOLUTE_PATHE_OF_CRONJOB
cd /mmoneyvar/dumps

#NOWDATE=$(date +"%F")
NOWDATE=DATE=`date '+%Y%m%d-%H%M%S'`
LOG_FILE_NAME="daily/jstack-$NOWDATE.log"
date >> $LOG_FILE_NAME
process=`ps -eaf | grep java | grep -v grep | awk '/muleTomcat-EIG/ {print $2}'`
echo "jstack" >> $LOG_FILE_NAME
/mmoneyhome/eig/jdk1.8.0_102/bin/jstack -l $process >> $LOG_FILE_NAME
date  >> $LOG_FILE_NAME
cd