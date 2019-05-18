# TCP flags
在TCP的連線中，TCP旗幟往往表示著特殊狀態下的連線情境，最常見的Flag有"SYN"、"ACK"以及"FIN"，每一個flag都含有1 bit的資訊量

# Synchronization(SYN)
對於三向交握，在第一次連線建立時會使用到該旗幟來做兩邊hosts的溝通
只有第一包從Sender送來的包會是SYN包，對應到Receiver會開啟一個對應的set儲存對應的flag
該SYN包兒開啟的set會儲存Synchronization sequence number來告訴系統，哪些sequence應該要期望被看到

# Acknowledgement(ACK)
用來表達從其他節點收到封包的感謝用封包
如果從節點送來的感封包其內容所帶的資訊是有效的，那麼就會被記錄在set裡面
```
e.g.
假使有個流程如下；
當Sender送出一個SYN包給Receiver時，嘗試做第一次握手
在第二次握手時，Receiver應該送出一個ACK=1的封包以及一個SYN=1的封包。告訴Sender他收到這個SYN包了

Sender(RISN=521)
---------------> Seq.= 521, SYN=1, MISS=1460B, window=14600B
                                                                Receiver(RISN=20000)
Seq.=2000, SYN-1, MISS=500B, window=10000B, ACK no.=522, ACK=1 <----------

Sender
---------------> Seq.=522, ACK no.=2001, ACK=1

開始資料傳輸...

*RISN - Random initial sequence number
SYN flag consumes 1 sequence number
ACK flag consumes 0 sequence number
Datatype consumes 1 sequence number
```

# Finish(FIN)：
通常在通信結束以後為了要中斷連結會需要做connection termination，此時不會再有任何資料從Sender送來。
同時，這表示這是最後一個從Sender送來的請求封包。當Receiver收到這個封包時，他會釋放所有預留的資源後優雅的終結這個連線
```
e.g.
Sender (Established Connection - active close FIN_WAIT_1)
------------> ACK + FIN
                    Receiver (Established Connection - CLOSE WAIT ...passive close)
ACK                         <----------------
                    Receiver (Established Connection - LAST_ACK ... then CLOSED)
ACK + FIN                   <----------------
Sender (FIN_WAIT_2) TIME_WAIT
------------> ACK

Sender (FIN_WAIT_2) closed after 2msl
```

# Reset(RST)：
這個旗幟是用來終結連線的。如果Sender覺得該連線存在疑慮，或是該連線不應該存在時會發送RST包給Receiver；告知Receiver，該包並非從預期的地方拿到的

```
比較Finish(FIN)與Reset(RST)包的差異
FIN: 優雅的關掉連結 <-> RST: 突兀的告訴Receiver停止這段對話

FIN: 只有其中一邊的對話會先停止 <-> RST: 兩邊的對話會同時停止

FIN: 確保不會有任何資料遺失 <-> RST: 有資料遺失的可能

FIN: Receiver會保留FIN包的資訊直到確認收到Sender的ACK <-> RST: Receiver會直接停止對話
```

# Push(PSH)
預設上來說傳輸層所有收到的包，都要在達到一定的量或是一段時間後才會Receiver送，如此一來才能減少網路上流量的開銷。但是有的請求需要立刻被通知。此時Sender可以透過PSH包(e.g. sets PSH=1)，如此會直接將包送往Receiver(忽略減少網路流量開銷的因素)，而Receiver收到包(PSH=1)的同時也會立即將包的內容送往應用層。
> 來自原文: In general, it tells the receiver to process these packets as they are received instead of buffering them.

# Urgent(URG)
當Receiver收到的包內涵(URG=1)時，這個包所需要處理的內容會優於其他包的執行

```
比較Push(PSH)與Urgent(URG)包的差異
PSH: sender所有在buffer內的資料都會直接被送到網路層(NL)/收到該包的Receiver會直接送往應用層(AL) <-> URG: 只有urgent資料會被送往應用層

PSH: 資料仍舊會依序列送出 <-> URG: 資料不會進入序列，會直接送出

```



# refer
https://www.geeksforgeeks.org/computer-network-tcp-flags/
https://blog.51cto.com/ilexes/154368
http://www.pcnet.idv.tw/pcnet/network/network_ip_tcp.htm
https://en.wikipedia.org/wiki/Transmission_Control_Protocol
https://blog.oldboyedu.com/tcp-wait/