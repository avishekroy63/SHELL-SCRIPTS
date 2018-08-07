/dev/tcp/172.27.34.72/8081 >/dev/null && echo EIG is UP || echo EIG is DOWN


WORKING --> echo > /dev/tcp/172.27.34.72/8081 >/dev/null && echo EIG is UP || echo EIG is DOWN

CURLSTATUS=$(curl https://172.26.98.68:5555/AirtelMoney -k -s -f -o /dev/null && echo "SUCCESS" || echo "ERROR")

curl -v telnet://172.27.34.27:17969 -k -s -f -o /dev/null && echo "SUCCESS" || echo "ERROR"




TEST BED : "172.27.34.27" port="17969"

TCPSTATUS=$(echo > /dev/tcp/172.27.34.27/17969 >/dev/null && echo "SUCCESS" || echo "ERROR" 2>/dev/null)

CURLSTATUS=$(curl telnet://172.27.34.27:17969 -v -s -f -o /dev/null && echo "SUCCESS" || echo "ERROR")

/mmoneyhome/AirtelProd/eig/muleTomcat_3.8-EIG/bin


TD

1. French Translation missings.
2. Himanshu to confirm over delete alternate number functionality and Go/NoGO depends on same.
3. report path is /mmoneyhome , replace it with /mmoneyvar.

GA
Sql SCRIPT Missing 

MW 
Do take backup of single command rather then backing up complete table.