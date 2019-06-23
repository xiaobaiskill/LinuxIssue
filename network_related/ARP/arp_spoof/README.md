# 前言
剛好看到大神分享如何以python實作arp spoof，所幸在學習arp。決定用docker打造一個arp spoof環境

# ARP and ARP spoofind
首先，ARP協議最主要是透過分析IP(L3網路層)位置來獲取MAC(L2實體鏈結層)的一個協議
```
正常網路: 在經過同一個路由(大家的MAC address都記錄在router裡)的情況下，Hacker拿不到Victim -> router的機密資料

Hacker --(Requests/Responses)-
                              |
                              |--- router ---> Internet 
                              |
Victim --(Requests/Responses)-


ARP Spoofing網路: Hacker拿到router的MAC address，所以Victim會把機密資料送到Hacker再從router那邊出去

Hacker --(Requests/Response) -
  |                           |
  |                           |--- router ---> Internet
  |
Victim
```

# 環境需求
docker, docker-compose

# 角色
Victim: 被竊聽的受害者;box1, box2
Hacker: 中間人，竊聽者;arpspoofing

# 使用方式
1. docker-compose up -d
2. 分別進入box1及box2的container內部輸入`ip addr`確認container內部ip
3. 進入Victim內部，輸入指令arpspoof -r -i eth0 -t ${box1_ip} ${box2_ip}
4. 再開一個新的terminal一樣進入Victim內部，使用tcpdump確認封包會不會送到Hacker這邊
5. 在box1下curl http://${box2_ip}，確認tcpdump是否有box1往box2的包以及box2回覆box1的包



# refer
https://github.com/BrunoVernay/lab-arpspoof

# extension
- 用於arp請求的python套件
  - scapy(linux限定):
  https://medium.com/@eric19921204/%E7%94%A8python-%E5%AF%AB%E4%B8%80%E5%80%8Barp-spoofer-783b1eef0acc
  - socket(linux限定):
  https://stackoverflow.com/questions/35348012/make-arp-request-on-python

- docker-compse的詳細模組設定
https://yeasy.gitbooks.io/docker_practice/compose/compose_file.html

- 在ubuntu下安裝arpspoofing
https://www.simplified.guide/linux/sniff-network-traffic

- arpspoofing的用法
https://blog.werner.wiki/usage-of-arpspoof/