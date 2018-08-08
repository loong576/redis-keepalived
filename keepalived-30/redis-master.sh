#!/bin/bash
rediscli="/usr/local/bin/redis-cli"
logfile="/var/log/redis_6379.log"
sync=`$rediscli info replication|grep master_sync_in_progress|awk -F: '{print $2}'|sed 's/\r//'`
#sync=`/usr/local/bin/redis-cli info replication|grep master_sync_in_progress|awk -F: '{print $2}'`
echo $sync
echo "-------------------change to master-------------------" >> $logfile 2>&1
date >> $logfile



if [ $sync == 0 ]; then :
    echo "the master_sync_in_progress is 0 and excute slaveof no one" >>$logfile 2>&1
    $rediscli slaveof no one
elif [ $sync == 1 ]; then :
    sleep 10
    $rediscli slaveof no one
else
    echo "the host is master,do nothing" >>$logfile 2>&1
fi


/etc/keepalived/exp.sh 172.27.9.31 monitor >>$logfile 2>&1
