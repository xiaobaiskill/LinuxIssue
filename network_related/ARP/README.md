# ARP欺騙
- ARP欺騙(ARP spoofing)，又稱ARP毒化(ARP poisoning，網路上多譯為ARP病毒)或ARP攻擊，是針對乙太網路位置解析協定(ARP)的一種攻擊技術。
- 此種攻擊可讓攻擊者取得區域網路上的資料封包甚至可竄改封包，且可讓網路上特定電腦或所有電腦無法正常連線。
- 最早探討ARP欺騙的文章是由Yuri Volobuev所寫的"ARP與ICMP轉向遊戲"(ARP and ICMP redirection games)

# 運作機制
- ARP欺騙的運作原理是由攻擊者發送假的ARP封包道網路上，尤其是閘道器上
- 目的是要讓送到指定的IP位址被錯誤送到攻擊者所取代的地方
- 因此攻擊者可將這些流量另行轉送到真正的閘道(被動式封包嗅探，passive sniffing)
- 或是算改後再轉送(中間人攻擊，man-in-the-middle attack)
- 攻擊者亦可將ARP封包導到不存在的MAC位址以達到阻斷服務攻擊的效果，例如netcut軟體
```
e.g. 某一的IP位址是192.168.0.254，其MAC位址為00-11-22-33-44-55，網路上的電腦內ARP表會有這一筆ARP紀錄
攻擊者發動攻擊時，會大量發出已將192.168.0.254的AMC位址算改為00-55-44-33-22-11的ARP封包
那麼，網路上的電腦若將此偽造的ARP寫入自身的ARP表後，電腦若要透過網路閘道連到其他電腦時
封包將會被導向00-55-44-33-22-11這個MAC位址，因此攻擊者可從此MAC位址截收到封包，可篡改後再送回真正的閘道，或是什麼也不做，讓網路無法連線
```
- Ethernet Type II Frame format.svg: 64-1518 bytes
MAC Header: 14 bytes
Data: 46-1500 bytes
CRC Checksum: 4bytes

MAC Header                |    MAC Header        |  MAC Header |  Data      |             |
--------------------------|:--------------------:|------------:|-----------:|--------------
Destination               |  Source MAC Address  |  Ether Type |  Payload   | CRC Checksum
80-00-20-7A-3E            |  80-00-20-20-3A-AE   |  08 00      |  IP,ARP,etc| 00-20-20-3A

```
Attack Example Analysis
假設一個LAN裡，只有三台主機A、B、C，且C是攻擊者
1. 攻擊者聆聽區域網路上的MAC位址。他只要收到兩台主機洪泛的ARP Request，就可以進行欺騙活動
2. 主機A、B都洪泛了ARP Request攻擊者現在有兩台主機的IP、MAC位址，開始攻擊
3. 攻擊者傳送一個ARP Reply給主機B，把此包protocol header裡的sender IP設為A的IP位址，sender mac設為攻擊者自己的MAC位址。
4. 主機B收到ARP Reply後，更新它的ARP表，把主機A的MAC位址(IP_A, MAC_A)改為(IP_A, MAC_C)
5. 當主機B要傳送封包給主機A時，它根據ARP表來封裝封包的Link報頭，把目的MAC位址設為MAC_C，而非MAC_A
6. 當交換機收到B傳送給A的封包時，根據此包的目的MAC位址(MAC_C)而把封包轉發給攻擊者C
7. 攻擊者收到封包後，可以把它存起來後再傳送給A，達到偷聽效果。攻擊者也可以篡改資料後才傳送封包給Ａ，造成傷害
```

# 限制方法
- 最理想的防制方法是網路內的每台電腦的ARP一律改用靜態的方式，不過這在大型的網路是不可行的，因為需要經常更新每台電腦的ARP表
> 另一種方法，例如DHCP snooping，網路裝置可藉由DHCP保留網路上各電腦的MAC位址，在偽造的ARP封包發出時即可偵測到。此方式在一些廠牌的網路裝置產品所支援
```
notes: 有些軟體可以監聽網路上的ARP回應，若偵測出有不正常變動時，可發送電子郵件通知管理者。例如UNIX平台的Arpwatch或是Windows上的XArp v2或有一些網路裝置的Dynamic ARP inspection功能
```

# 正常用途
ARP欺騙亦有正當用途
1. 在一個需要登入的網路中，讓為登入的電腦將其瀏覽器網頁強制轉向到登入頁面，以便登入後才可使用網路
2. 有些設備有備援機制的網路裝置或伺服器，亦需要利用ARP欺騙以在裝置出現故障時將訊務導到備用的裝置上

# refer
https://zh.wikipedia.org/wiki/ARP%E6%AC%BA%E9%A8%99