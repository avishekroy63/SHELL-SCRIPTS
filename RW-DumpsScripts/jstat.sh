#cd ABSOLUTE_PATHE_OF_CRONJOB
cd /mmoneyvar/dumps

NOWDATE=$(date +"%F")
LOG_FILE_NAME="daily/jstat-$NOWDATE.log"
echo "*************************************" >> $LOG_FILE_NAME
echo "Starting the schedule process in cron" >> $LOG_FILE_NAME
echo "*************************************" >> $LOG_FILE_NAME
echo "The current time is:" >> $LOG_FILE_NAME
date >> $LOG_FILE_NAME
process=`ps -eaf | grep java | grep -v grep | awk '/muleTomcat_3.8-EIG/ {print $2}'`
echo "gcutil" >> $LOG_FILE_NAME
jstat -gcutil $process >> $LOG_FILE_NAME
echo "gccapacity" >> $LOG_FILE_NAME
jstat -gccapacity $process >> $LOG_FILE_NAME
echo "gcoldcapacity" >> $LOG_FILE_NAME
jstat -gcoldcapacity $process >> $LOG_FILE_NAME

echo "*************************************" >> $LOG_FILE_NAME
echo "End of the schedule process in cron  " >> $LOG_FILE_NAME
echo "*************************************" >> $LOG_FILE_NAME
echo "The current time is:"  >> $LOG_FILE_NAME
date  >> $LOG_FILE_NAME
cd
