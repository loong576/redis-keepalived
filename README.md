# redis-keepalived
keepalived+expect方式实现redis主从高可用

**架构：**

![Image text](https://raw.githubusercontent.com/loong576/redis-keepalived/master/img-folder/redis-keepalived02.jpg)



redis高可用有Sentinel、Cluster等多种方式，本文主要介绍keepalived方式。

keepalived常用的实现高可用方式是当检查到被监控进程或keepalived服务本身挂掉时触发切换。

这种方式对于redis主从高可用会有一个问题：当主的keepalived挂掉时，此时无法触发keepalived里的notify_backup脚本，主的redis状态还是master；此时从服务器会接管vip并且redis状态由slave切换为master，这时就会有两个master，主从架构被破坏。

为了解决该问题，在notify_master脚本使用expect工具，本文在主从发生切换时，切换为master的主机会触发notify_master脚本，该脚本中的expect工具会远程到对方主机执行slaveof命令，重新确定主从关系。

文章链接：http://blog.51cto.com/3241766/2156226
