# 透過ovs了解一些關於網路協定以及相關的設定
Openvswitch是一種虛擬交換器，可以用來作L2 Switch，切割網域，QoS或是流量監控，同時支援openFlow協定

# 常見名詞定義
- Bridge: 對應物理的交換器，作用是根據規則做Packet轉發
- Port: 接收Packet的街口，可以根據Flow把Packet送到其他Port，包含Normal、Internal、Patch、Tunnel類型
- Fail mode: 當和Controller連接失敗時
- Standalone: 作為一般L2/L3交換器
- secure: 一定要連上controller才處理封包

# 架構
ovsdb-server: 管理ovsdb
ovsdb存放vswitch相關資料，EX: Bridge, Port, Interface, Flow Table, QoS, sFlow config
ovs-vswitch ovs daemon用來控制vswitch

# ovs各元件
ovs-dpctl: 管理ovs datapath，大部分資訊都是透過netlink反映出
ovs-vsctl: 對ovsdb操作，bridge, interface 新增，刪除，查詢，操作指令比較具有語意，會幫你轉化成ovsdb看得懂的語法
ovs-ofctl: openflow switch管理工具，可以操作與openflow相關的設定
ovs-appctl: ovs-vswithd的管理工具，可以跟ovs-vswitchd程序溝通，ex: ofproto/trace可用來追蹤封包flow
ovs-docker: 提供與docker container的連接

# 建造ovs步驟
1. [安裝ovs] 環境必須要是linux(mac 目前不支援)... apt-get install openvswitch-switch -y
2. [增加一個bridge] ovs-vsctl add-br br0
3. [將interface綁定在Bridge br0並設定type=internel] ovs-vsctl add-port br0 interface -- set interface type=internel
4. [查看switch狀態] ovs-vsctl show
5. [新增Flow Entry] ovs-ofctl add-flow br0 "table=0, priority=0, actions=drop"
6. [查詢Bridge Flow Entry] ovs-ofctl dump-flows br0
7. [綁定container至ovs] docker run -itd --name=c1 --network=none busybox
8. [綁定至ovs] ovs-docker add-port br0 t2 c2 --ipaddress=10.0.0.1/24
9. [查看Bridge br0轉發] ovs-appctl fdb/show br0
10. [查看Bridge br0[port]的流量] ovs-ofctl dump-ports br0 [port]
11. [查看Log] ovsdb-tool show-log -m


# ovs的相關參考文章
https://reurl.cc/3357X
https://ithelp.ithome.com.tw/articles/10197632

# 網路相關知識延伸閱讀
https://ithelp.ithome.com.tw/articles/10197629
https://ithelp.ithome.com.tw/articles/10197631

# docker container網路層設定
https://docs.docker.com/v17.09/engine/userguide/networking/#default-networks
https://cumulusnetworks.com/blog/5-ways-design-container-network/

# 關於switch
https://zh.wikipedia.org/wiki/%E7%B6%B2%E8%B7%AF%E4%BA%A4%E6%8F%9B%E5%99%A8
https://zh.wikipedia.org/wiki/%E8%99%9A%E6%8B%9F%E5%B1%80%E5%9F%9F%E7%BD%91
http://www.cs.nthu.edu.tw/~nfhuang/chap16.htm
