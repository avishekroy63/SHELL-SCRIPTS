#!/bin/bash
stack1=`ps auxw | grep tomcat7_mtxn | grep -v grep | wc -l`
now=$(date +%s)
DATE=$(date +"%F")
pid=`ps -eaf | grep java | grep -v grep | awk '/tomcat7_mtxn/ {print $2}'`
echo $now
echo "$stack1"
	if [ $stack1 == 0 ]
        then
			echo "INTANCE NOT RUNNING NO ACTION REQUIRED" 
	else
		echo "INSTANCE IS RUNNING -> STACK WILL NOW CHECK FOR CONNECTION RESET ERROR"

		RESETCOUNT=$(tail -n50 /mmoneyvar/mmoney_bxlogs/HSMServer.log | grep -c "XmlRpcClient I/O error while communicating with HTTP server: Connection reset")
                        if [ $RESETCOUNT -gt 10 ]
			then
				sh /mmoneyvar/eventcapture/linux-perf-eventcapture.sh
				sleep 60
				DUMPSTATUS=$(ps -eaf | grep "linux-perf-eventcapture.sh" | grep -v grep | wc -l)
				while [ $DUMPSTATUS -gt 0 ]
				do
					echo "RELAX DUMPS IS IN-PROGRESS"
					DUMPSTATUS=$(ps -eaf | grep "linux-perf-eventcapture.sh" | grep -v grep | wc -l)
					sleep 20
				done
					RESETCOUNT=$(tail -n50 /mmoneyvar/mmoney_bxlogs/HSMServer.log | grep -c "XmlRpcClient I/O error while communicating with HTTP server: Connection reset")
                    			if [ $RESETCOUNT -gt 10 ]
					then
						echo "Services Seems DOWN"
						echo "Going to start  SERVICES"
						cd "mmoneyhome/txn/tomcat7_mtxn/bin"
						kill -9 $pid
						#Starting EIG
						./mobiquityStart.sh  1>/dev/null 2>/dev/null
						echo "TXN STARTED AT $DATE" >> /mmoneyvar/hang/logs/txnhang.log
						echo "EIG STARTED AT $DATE" >> /mmoneyvar/hang/logs/alertlog1.log
						sleep 60
					else
						echo "SERVICES R RUNNING FINE AS NO CONNECTION RESET ERROR"
					fi
			else
				echo "SERVICES R RUNNING FINE AS NO CONNECTION RESET ERROR"
			fi
	fi