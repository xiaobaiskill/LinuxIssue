# 紀錄使用tcpdump

# 監視指定網卡的封包
1. 聽取某一個網卡的封包
```
tcpdump -i eth1
```

# 監視指定主機的封包
1. 聽取有進入或離開sundown的封包: host
```
tcpdump host sundown
```

1. 聽取所有來自特定ip的封包: host `ip`
```
tcpdump host 210.27.48.1
```

1. 聽取主機 210.27.48.1 和 210.27.48.2 or 210.27.48.3 間的封包: `ip` and  (`ip` or `ip` )
```
tcpdump host 210.27.48.1 and 210.27.48.2 or 210.27.48.3
```

1. 打印ace與任何其他主機間通信的ip封包，但不包括雨helios之間的封包: `ip host` and `not`
```
tcpdump ip host ace and not helios
*備註：ace是一個事先定義在host裡面的主機名
```

1. 獲取主機210.27.48.1而非210.27.48.2的ip封包: `!`
```
tcpdump ip host 210.27.48.1 and ! 210.27.48.2
```

1. 獲取所有送到主機hostname的封包: `src`
```
tcpdump -i eth0 src host hostname
```

1. 監視所有送到主機hostname的封包: `dst`
```
tcpdump -i eth0 dst host hostname
```

# 監視指定主機和端口的封包
1. 監視主機210.27.48.1所接收或發出的telnet封包
```
tcpdump tcp port 23 and host 210.27.48.1
```

1. 對本機udp 123端口進行監視123為ntp的服務端口
```
tcpdump udp port 123 
```

# 監視指定網路的封包
1. 印出本地主機與Berkeley網路上的主機之間的所有通信封包(nt: ucb-ether, 其中'ucb-ether'表示'Berkeley網路'的網路地址，又或者說印出所有網路地址為'ucb-ether'的封包)
```
tcpdump net ucb-ether
```
1. 印出所有通過網關snup的ftp封包(使用 `' '` 來防止shell對括號內的指令解析錯誤)
```
tcpdump 'gateway snup and (port ftp or ftp-data)'
```
1. 打印所有原地址或目標地址是本地主機的ip封包
(如果本地網路通過網關到了另一網路，則另一網路不算做本地網路)
```
tcpdump ip and not net localnet
```

# tcpdump 與 wireshark
1. Wireshark(以前是ethereal)與tcpdump配合解析/監聽封包
```
tcpdump tcp -i eth1 -t -s 0 -c 100 and dst port ! 22 and src net 192.168.1.0/24 -w ./target.cap


(1)tcp: ip icmp arp rarp 和 tcp、udp、icmp这些选项等都要放到第一个参数的位置，用来过滤数据报的类型
(2)-i eth1 : 只抓经过接口eth1的包
(3)-t : 不显示时间戳
(4)-s 0 : 抓取数据包时默认抓取长度为68字节。加上-s 0 后可以抓到完整的数据包
(5)-c 100 : 只抓取100个数据包
(6)dst port ! 22 : 不抓取目标端口是22的数据包
(7)src net 192.168.1.0/24 : 数据包的源网络地址为192.168.1.0/24
(8)-w ./target.cap : 保存成cap文件，方便用ethereal(即wireshark)分析
```
1. 使用tcpdump抓HTTP封包
```
tcpdump  -XvvennSs 0 -i eth0 tcp[20:2]=0x4745 or tcp[20:2]=0x4854

0x4745 为"GET"前两个字母"GE",0x4854 为"HTTP"前两个字母"HT"。

 

tcpdump 对截获的数据并没有进行彻底解码，数据包内的大部分内容是使用十六进制的形式直接打印输出的。显然这不利于分析网络故障，通常的解决办法是先使用带-w参数的tcpdump 截获数据并保存到文件中，然后再使用其他程序(如Wireshark)进行解码分析。当然也应该定义过滤规则，以避免捕获的数据包填满整个硬盘。
```

# reference:
1. https://www.cnblogs.com/ggjucheng/archive/2012/01/14/2322659.html
2. 
