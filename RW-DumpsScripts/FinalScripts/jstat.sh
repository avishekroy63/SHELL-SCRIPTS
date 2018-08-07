#cd ABSOLUTE_PATHE_OF_CRONJOB
cd /mmoneyvar/dumps

NOWDATE=$(date +"%F")
LOG_FILE_NAME="daily/jstat-gcutil-$NOWDATE.log"
process=`ps -eaf | grep java | grep -v grep | awk '/muleTomcat-EIG/ {print $2}'`
/mmoneyhome/eig/jdk1.8.0_102/bin/jstat -gcutil -t $process 300000 285 >> $LOG_FILE_NAME
cd