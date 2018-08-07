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
		echo "INSTANCE IS RUNNING -> STACK WILL NOW CHECK FOR CURL OUTPUT"
		CURLSTATUS=$(curl https://172.26.114.245:5555/AirtelMoney -k -s -f -o /dev/null && echo "SUCCESS" || echo "ERROR")
			if [ $CURLSTATUS == "SUCCESS" ]
			then
				echo "SEEMS CURL STATUS IS FINE -> NO ACTION REQUIRED"
			else
				UPTIME=$(stat -c %Y /proc/"$pid")
				DIFF=$((now-UPTIME))
				echo $DIFF
				if [ $DIFF -gt 1800 ]
				then
					echo "Services Seems DOWN"
					echo "Going to start  SERVICES"
					cd "/home/test/tomcat7_web/bin"
					kill -9 $pid
					#Starting TXN
					./mobiquityStart.sh  1>/dev/null 2>/dev/null
					echo "WEB STARTED AT $DATE" >> /mmoneyvar/hang/logs/webservicehang.log
					echo "WEB STARTED AT $DATE" >> /mmoneyvar/hang/logs/alertlog1.log
					sleep 120
					#CHECK FOR DBConn AND CURLSTATUS
					DBConn=`netstat -an | grep 1908  |grep ESTABLISHED | wc -l`
					echo $CURLSTATUS
					echo "CURRENT NUMBER OF DB CONNECTIONS : $DBConn"
					sleep 60
				else
					echo "PROCESS UPTIME IS LESS THAN 30MINS -> NO ACTION REQUIRED"
				fi
			fi
	fi
