#cd ABSOLUTE_PATHE_OF_CRONJOB
cd /mmoneyvar/dumps

NOWDATE=$(date +"%F")
LOG_FILE_NAME="daily/jstack-$NOWDATE.log"
echo "*************************************" >> $LOG_FILE_NAME
echo "Starting the schedule process in cron" >> $LOG_FILE_NAME
echo "*************************************" >> $LOG_FILE_NAME
echo "The current time is:" >> $LOG_FILE_NAME
date >> $LOG_FILE_NAME
process=`ps -eaf | grep java | grep -v grep | awk '/muleTomcat_3.8-EIG/ {print $2}'`
echo "jstack" >> $LOG_FILE_NAME
/usr/bin/jdk1.6.0_29/bin/jstack -l -F $process >> $LOG_FILE_NAME

echo "*************************************" >> $LOG_FILE_NAME
echo "End of the schedule process in cron  " >> $LOG_FILE_NAME
echo "*************************************" >> $LOG_FILE_NAME
echo "The current time is:"  >> $LOG_FILE_NAME
date  >> $LOG_FILE_NAME
cd
