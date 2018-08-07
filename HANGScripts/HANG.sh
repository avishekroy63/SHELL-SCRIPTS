stack1=`ps auxw | grep tomcat7_mtxn | grep -v grep | wc -l`
now=$(date +%s)
echo $now
echo "$stack1"
	if [ $stack1 == 0 ]
        then
			echo "INTANCE NOT RUNNING NO ACTION REQUIRED" 
	else
		echo "INSTANCE IS RUNNING -> STACK WILL NOW CHECK FOR DB CONNECTIONS"
		DBConnections=`netstat -anp | grep "$pid/java" | grep 1908  |grep ESTABLISHED | wc -l`
			if [ $DBConnections != 0 ]
				echo "SEEMS DB CONNECTIONS EXISTS -> NO ACTION REQUIRED"
			else
				pid=`ps -eaf | grep java | grep -v grep | awk '/tomcat7_mtxn/ {print $2}'`
				UPTIME=$(stat -c %Y /proc/"$pid")
				DIFF=$((now-UPTIME))
				$DIFF
				if [ DIFF -gt 1800 ]
					echo "Services Seems DOWN"
					echo "Going to start  SERVICES"
					cd /mmoneyhome/txn/tomcat7_mtxn/bin

					#Starting TXN
					./mobiquityStart.sh  1>/dev/null 2>/dev/null &
					echo "TXN STARTED AT $now" >> /mmoneyvar/hang/logs/txnservicehang.log
					sleep 60
					DBConn=`netstat -an | grep 1908  |grep ESTABLISHED | wc -l`
					echo "CURRENT NUMBER OF DB CONNECTIONS : $ DBConn"
					sleep 60
				else
					echo "PROCESS UPTIME IS LESS THAN 30MINS -> NO ACTION REQUIRED"
				fi
			fi
	fi

	if [ $(curl -sL -w "%{http_code}\\n" "google.com:8080/"; -o /dev/null --connect-timeout 3 --max-time 5) == "200" ] ; then echo "OK" ; else echo "KO" ; fi 
	

echo "Going to start  TXN"
                cd /mmoneyhome/txn/tomcat7_mtxn/bin

                #Starting TXN
                 ./mobiquityStart.sh  1>/dev/null 2>/dev/null &
				 
				 
				 
[test@testserver bin]$ ps -p 8151 -o etimes
[test@testserver bin]$ ps -p 3723 -o etime
    ELAPSED
24-02:08:04

[test@testserver bin]$ cat /tmp/test.sh 
# example pid here is just your shell
pid=8151

# current unix time (seconds since epoch [1970-01-01 00:00:00 UTC])
now=$(date +%s)

# process start unix time (also seconds since epoch)
# I'm fairly sure this is the right way to get the start time in a machine readable way (unlike ps)...but could be wrong
start=$(stat -c %Y /proc/"$pid")

# simple subtraction (both are in UTC, so it works)
age=$((now-start))

printf "that process has run for %s seconds\n" "$age"