# Recv-Q and Send-Q
Recv-Q Send-Q分別表示網絡接收佇列及發送佇列; Q是Queue的縮寫
這兩個值通常應該為0，如果不為0則代表有可能有問題。
packets在兩個佇列理論上都不應為0，但可以接受短暫的非0情況。

如果接受佇列Recv-Q一直處於阻塞狀態，可能是遭受了拒絕服務denial-of-service攻擊
如果發送佇列Send-Q不能很快的清零，可能是有應用向外發送數據包過快，或者對方接收數據包不夠快

Recv-Q: 表示收到的數據已經在本地接收緩沖，但是還有多少沒有被進程取走，recv()
Send-Q: 對方沒有收到的數據或者說沒有Ack的，還是本地緩沖區


# netstat
1. 通過netstat -anp可以查看機器當前的連接狀態
```
~ ➤ netstat -anp
(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      -
tcp        0      0 10.140.0.7:53126        169.254.169.254:80      ESTABLISHED -
tcp        0      0 10.140.0.7:53128        169.254.169.254:80      ESTABLISHED -
tcp        0      0 10.140.0.7:60254        10.140.0.7:2377         ESTABLISHED -
tcp        0      0 10.140.0.7:53130        169.254.169.254:80      ESTABLISHED -
tcp        0    660 10.140.0.7:22           59.124.115.148:59398    ESTABLISHED -
tcp        0      0 10.140.0.7:53124        169.254.169.254:80      CLOSE_WAIT  -
tcp6       0      0 :::8002                 :::*                    LISTEN      -
tcp6       0      0 :::8003                 :::*                    LISTEN      -
```

# ss
當伺服器的socket連接數量過大時(上萬筆)，使用netstat或是cat /proc/net/tcp執行速度都會偏慢，使用ss會比較快。
ss快的秘訣在於，他利用TCP協議中的tcp_diag可以獲得Linux內核中第一手信息，確保了ss的快捷高效。
1. 通過ss -t -a查看，TCP連結的狀態以及Recv-Q和Send-Q狀態
```
~ ➤ ss -t -a
State            Recv-Q        Send-Q  Local Address:Port      Peer Address:Port
LISTEN           0             128     127.0.0.53%lo:domain         0.0.0.0:*
LISTEN           0             128           0.0.0.0:ssh            0.0.0.0:*
ESTAB            0             0          10.140.0.7:53354  169.254.169.254:http
ESTAB            0             76         10.140.0.7:ssh     59.124.115.148:61266
ESTAB            0             0          10.140.0.7:60254       10.140.0.7:2377
CLOSE-WAIT       0             0          10.140.0.7:53348  169.254.169.254:http
ESTAB            0             0          10.140.0.7:53352  169.254.169.254:http
ESTAB            0             0          10.140.0.7:53356  169.254.169.254:http
LISTEN           0             128                 *:8002                 *:*
LISTEN           0             128                 *:8003                 *:*
LISTEN           0             128                 *:8004                 *:*
LISTEN           0             128                 *:8005                 *:*
LISTEN           0             128                 *:8999                 *:*
LISTEN           0             128                 *:2377                 *:*
LISTEN           0             128                 *:7946                 *:*
LISTEN           0             128                 *:6379                 *:*
LISTEN           0             128                 *:http                 *:*
LISTEN           0             128                 *:9200                 *:*
LISTEN           0             128                 *:http-alt             *:*
LISTEN           0             128                 *:8086                 *:*
LISTEN           0             128              [::]:ssh               [::]:*
LISTEN           0             128                 *:https                *:*
LISTEN           0             128                 *:8443                 *:*
LISTEN           0             128                 *:8000                 *:*
LISTEN           0             128                 *:5601                 *:*
LISTEN           0             128                 *:8001                 *:*
ESTAB            0             0  [::ffff:10.140.0.7]:2377  [::ffff:10.140.0.7]:60254
```
2. 通過ss -s顯示Sockets摘要
```
~ ➤ ss -s
Total: 667 (kernel 0)
TCP:   50 (estab 6, closed 23, orphaned 0, synrecv 0, timewait 0/0), ports 0

Transport Total     IP        IPv6
*	  0         -         -
RAW	  0         0         0
UDP	  4         3         1
TCP	  27        8         19
INET	  31        11        20
FRAG	  0         0         0
```
3. 通過ss -pl顯示目前socket的進程使用狀況，以下透過grep查詢特定port的狀況
```
~ ➤ ss -pl |grep ":80"
tcp               LISTEN              0                    128                                                                                                *:8002                             *:*
tcp               LISTEN              0                    128                                                                                                *:8003                             *:*
tcp               LISTEN              0                    128                                                                                                *:8004                             *:*
tcp               LISTEN              0                    128                                                                                                *:8005                             *:*
tcp               LISTEN              0                    128                                                                                                *:8086                             *:*
tcp               LISTEN              0                    128                                                                                                *:8000                             *:*
tcp               LISTEN              0                    128                                                                                                *:8001                             *:*
```


# 補充
From netstat man page: This program is obsolete. Replacement for netstat is ss. Replacement for netstat -r is ip route. Replacement for netstat -i is ip -s link. Replacement for netstat -g is ip maddr. 

# refer
1. https://www.cnblogs.com/leezhxing/p/5329786.html
2. https://blog.csdn.net/sjin_1314/article/details/9853163
3. https://blog.csdn.net/qq_14821541/article/details/52047789

- support for mac net utility
https://superuser.com/questions/724712/what-is-the-equivalent-of-ss-for-mac