#!/bin/bash
stack1=`ps auxw | grep muleTomcat_3.8-EIG | grep -v grep | wc -l`
now=$(date +%s)
DATE=$(date +"%F")
pid=`ps -eaf | grep java | grep -v grep | awk '/muleTomcat_3.8-EIG/ {print $2}'`
echo $now
echo "$stack1"
        if [ $stack1 == 0 ]
        then
                        echo "INTANCE NOT RUNNING NO ACTION REQUIRED"
        else
                echo "INSTANCE IS RUNNING -> STACK WILL NOW CHECK FOR PORT and CLOSEWAIT STATUS"

                PORTSTATUS=$(echo > /dev/tcp/172.27.34.27/17999 >/dev/null && echo "SUCCESS" || echo "ERROR" 2>/dev/null)
                CLOSEWAIT=$(netstat -ant | grep CLOSE_WAIT | grep 17999 | grep -v grep | wc -l )
                LOAD1=$(cat /proc/loadavg | cut -d ' ' -f1)
                LOAD=${LOAD1/.*}
                        if [ $PORTSTATUS == "ERROR" ] || [ $CLOSEWAIT -gt 2000 ] || [ $LOAD -gt 20 ]
                        then
                                sh /mmoneyhome/AirtelProd/scripts/linux-perf-eventcapture.sh
                                sleep 60
                                DUMPSTATUS=$(ps -eaf | grep "linux-perf-eventcapture.sh" | grep -v grep | wc -l)
                                while [ $DUMPSTATUS -gt 0 ]
                                do
                                        echo "RELAX DUMPS IS IN-PROGRESS"
                                        sleep 60
                                done
                                        PORTSTATUS=$(echo > /dev/tcp/172.27.34.27/17999 >/dev/null && echo "SUCCESS" || echo "ERROR" 2>/dev/null)
                                        CLOSEWAIT=$(netstat -anp | grep CLOSE_WAIT | grep 17999 | grep -v grep | wc -l )
                                        LOAD1=$(cat /proc/loadavg | cut -d ' ' -f1)
                                        LOAD=${LOAD1/.*}
                                        if [ $PORTSTATUS == "ERROR" ] || [ $CLOSEWAIT -gt 2000 ] || [ $LOAD -gt 20 ]
                                        then
                                                echo "Services Seems DOWN"
                                                echo "Going to start  SERVICES"
                                                cd "/mmoneyhome/AirtelProd/eig/muleTomcat_3.8-EIG/bin"
                                                kill -9 $pid
                                                #Starting EIG
                                                ./muleStart.sh  1>/dev/null 2>/dev/null
                                                echo "EIG STARTED AT $DATE" >> /mmoneyhome/AirtelProd/scripts/webservicehang.log
                                                echo "EIG STARTED AT $DATE" >> /mmoneyhome/AirtelProd/scripts/alertlog1.log
                                                sleep 60
                                        else
                                                echo "SERVICES R RUNNING FINE AS PORT AND LOAD CHECK IS FINE"
                                        fi
                        else
                                echo "SERVICES R RUNNING FINE AS PORT AND LOAD CHECK IS FINE"
                        fi
        fi