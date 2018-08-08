#!/bin/sh
rediscli="/usr/local/bin/redis-cli"
logfile="/var/log/redis_6379.log"
result=$($rediscli ping)
echo $result


echo "-------------------redis-check-------------------" >> $logfile
date >> $logfile
if [ $result == "PONG" ]; then : 
   echo "Success: the result is $result" >> $logfile 2>&1
   exit 0 
else 
   echo "Failed:the result is $result " >> $logfile 2>&1
   exit 1 
fi
