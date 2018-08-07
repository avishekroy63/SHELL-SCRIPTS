stack1=`ps auxw | grep tomcat7_web | grep -v grep | wc -l`
now=$(date +%s)
DATE=$(date +"%F")
pid=`ps -eaf | grep java | grep -v grep | awk '/tomcat7_web/ {print $2}'`
echo $now
echo "$stack1"
	if [ $stack1 == 0 ]
        then
			echo "INTANCE NOT RUNNING NO ACTION REQUIRED" 
	else
		echo "INSTANCE IS RUNNING -> STACK WILL NOW CHECK FOR GREP OUTPUT"
		cd "/mmoneyhome/web/tomcat7_web/logs"
		GREPSTATUS=$(grep -q "java.lang.OutOfMemoryError" localhost.$DATE.log /dev/null && echo "SUCCESS" || echo "FAIL")
			if [ $GREPSTATUS == "FAIL" ]
			then
				echo "SEEMS GREP STATUS IS FINE -> NO ACTION REQUIRED"
			else
				UPTIME=$(stat -c %Y /proc/"$pid")
				DIFF=$((now-UPTIME))
				echo $DIFF
				if [ $DIFF -gt 5 ]
				then
					echo "Services Seems DOWN as due to Java Heap Space"
					echo "Going to start  SERVICES"
					kill -9 $pid
					cd "/mmoneyhome/web/tomcat7_web/logs"
					cp localhost.$DATE.log localhost.$DATE.log.BACKUP_$now
                                        cat /dev/null > localhost.$DATE.log
					#Starting TXN
					cd "/mmoneyhome/web/tomcat7_web/bin"
					./mobiquityStart.sh  1>/dev/null 2>/dev/null
					echo "WEB STARTED AT $DATE" >> /mmoneyvar/hang/logs/webservicehang.log
					echo "WEB STARTED AT $DATE" >> /mmoneyvar/hang/logs/alertlog1.log
					sleep 120
					#CHECK FOR DBConn AND GREPSTATUS
					DBConn=`netstat -an | grep 1908  |grep ESTABLISHED | wc -l`
					echo $GREPSTATUS
					echo "CURRENT NUMBER OF DB CONNECTIONS : $DBConn"
					sleep 60
				else
					echo "PROCESS UPTIME IS LESS THAN 30MINS -> NO ACTION REQUIRED"
				fi
			fi
	fi