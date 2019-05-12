# TCP流程
TCP流程示意圖，client向server發起SYN，server回應SYN+ACK。client回應ACK
```
Client                  Server
         SYN
 ----------------------->
        SYN, ACK
<------------------------
        ACK
 ------------------------>
```

# 關於tcp queue
1. 當client通過connect向server發出SYN包時，client會起一個socket queue去送包，相對的server也會起一個socket queue去接SYN包
2. 此時進入半連接狀態，如果server socket queue滿了，client端會被返回connection time out;只要是client沒有收到SYN+ACK，3s之後，client會再次發送。接著9s之後再繼續發送
3. 半連接SYN queue的長度為max(64, /proc/sys/net/ipv4/tcp_max_syn_backlog)決定
```
~ ➤ cat /proc/sys/net/ipv4/tcp_max_syn_backlog
128
```
4. 當server收到client的SYN包後，會返回SYN+ACK的包加以確認，client的TCP協議會喚醒socket queue，發出connect請求
5. client返回ACK的包後，server會進入一個新的叫accept的queue，該queue的長度為min(backlog, somaxconn)，默認情況下，somaxconn的值為128，表示最多有129個ESTAB的連接等待accept()，而非backlog的值則由in listen(int sockfd, int backlog)中的第二個參數指定。
6. 當accept queue滿了以後，即使client繼續向server發送ACK的包，也會不被相應。此時，server通過/proc/sys/net/ipv4/tcp_abort_on_overflow來決定如何返回，0表示直接丟棄該ACK，1表示發送RST通知client;相應的，client則會分別返回read timeout或者connection reset by peer。
```
~ ➤ cat /proc/sys/net/ipv4/tcp_abort_on_overflow
0
```
notes:
如果服務器不及時的調用accept()，當queue滿了之後，服務器並不一定會不再對SYN(丟棄ACK包或是發送RST包)返回ETIMEOUT。而是會隨機忽略收到的SYN，建立起來的連接數可以無限的增加，只不過client端會遇到延時及超時的情況。

# 歸納
tcp stack可已看到兩個queue
1. 一個是half open(syn queue) queue(max(tcp_max_syn_backlog, 64))，用來保存SYN_SENT以及SYN_RECV的信息
2. 另一個是accept queue(min(somaxconn, backlog))，保存ESTAB的狀態，但是調用accept()

# 補充:一些關於ss -at裡面的State表示意思
- LISTEN狀態：Recv-Q表示當前等待服務端調用accept完成三次握手的listen backlog數值，即當client端通過connect()去連接正在listen()的服務端時，這些連接會一直處於queue裡面直到被服務端accept();Send-Q表示的則是最大的listen backlog數值。
- 非LISTEN狀態：Recv-Q表示receive queue中的bytes數量;Send-Q表示send queue中的bytes數值

# case study
http://blog.chinaunix.net/uid-20662820-id-4154399.html
https://www.percona.com/blog/2011/04/19/mysql-connection-timeouts/

> 引用自原文：
```
1. 通過"SYNs to LISTEN sockets dropped"以及"times the listen queue of a socket overflowed"這兩個netstat -s的TCP狀態，可以很快發現系統存在問題
2. 任何一個包含"dropped"或者"overflowed"並且數值一直居高不下的metric從字面涵義理解來看，都不是好現象
3. 假使，nginx來說backlog默認為511，可以通過ss/netstat去檢查Send-Q，可以通過適當的增大nginx的backlog以及somaxconn來增大queue
4. 如果發現一個系統的State經常顯示"times the listen for a socket overflowed"可以嘗試通過增加backlog來緩解該問題
```

# refer
http://jaseywang.me/2014/07/20/tcp-queue-%E7%9A%84%E4%B8%80%E4%BA%9B%E9%97%AE%E9%A2%98/
https://www.douban.com/note/178129553/
https://madalanarayana.wordpress.com/2014/04/13/learnings-on-tcp-syn/


# extend-refer
http://engineering.chartbeat.com/2014/01/02/part-1-lessons-learned-tuning-tcp-and-nginx-in-ec2/
http://engineering.chartbeat.com/2014/02/12/part-2-lessons-learned-tuning-tcp-and-nginx-in-ec2/