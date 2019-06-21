# GSLB - Global Server Load Balancing\ Global Software Load Balancing\ Global Site Load Balancing

所謂全球伺服器負載平衡(Global Server Load Balancing；GSLB)，究其本質，亦不脫負載平衡技術範疇，也是用以提高伺服器處理能力，並具備提高應用服務穩定性、可用度、可維護性等意涵，然在結構上，與一般較為常見之本地伺服器負載平衡(Server Load Balancing；SLB)有所不同，因為GSLB旨在針對置於不同地域、不同網路的伺服器集群之間，實施負載平衡，不僅止於本地端的伺服器集群，故其管理應用範圍相對遼闊。

- 大型網際網路公司應用GSLB主要兩項目標
1. 提高系統的可用性(availability)
    1. 當某個站點/集群整體不可用時，系統仍然可以通過其他站點/集群提供完整且可用的服務
2. 降低用戶的訪問延遲(latency)
    1. 根據用戶地理位置，將請求發送到最近的站點/集群提供服務，降低用戶的請求延遲，改進用戶體驗


在此前提下，GSLB其實可以被這麼形容，便是設圖將偌大的網際網路世界，切割成為多個區塊，從而以最迅捷、且不間斷的方式，為使用者提供最佳造訪路徑，協助其鏈結到最適合的區塊，終至提高使用者存取各項資訊應用服務之效率；

此外，綜觀整體內容傳遞網路(Content Delivery Network；CDN)技術，有關使用者存取路徑之重新導向(Redirect)策略，GSLB堪稱箇中甚為關鍵的技術項目，此乃由於，GSLB控制器能夠以直接或間接的方式，取得各地CDN節點中邊緣伺服器的運作狀態、效能情況，且有能力判斷使用者來源，藉以確保使用者，都能被有效地分配到距離其「邏輯上」最近、且最健康的節點上。

# 底層技術上
基於DNS的GSLB，夠過DNS實現第一層的負載均衡。某種層面上，也可以說GSLB是透過DNS方得以實踐的
1. local balancer上報數據給global balancer，global balancer匯總local balancer上抱的數據，並將匯總後的數據發給authoritative DNS，authoritative DNS會根據global balancer上報的數據調整返回給用戶的IP地址
2. 用戶打開瀏覽器，通過ISP DNS遞歸查詢網址www.example.com對應的IP用戶，最終authoritative DNS會返回一個IP位址給ISP DNS，ISP DNS返回IP給用戶，瀏覽器發送請求到IP位址對應的伺服器集群

### 基於DNS load balancer的問題
1. 如何返回最優IP
一般情況下，example.com的authoritative DNS可以根據源請求IP返回最近的example.com集群IP，有可能該回應是參照本地ISP DNS的IP返回的
這會涉及一個問題，如果本地ISP沒有DNS而是使用其他上級ISP的DNS，client端有可能會得到很遠的集群IP(假如本地ISP使用到錯誤的ISP進行DNS遞歸查詢);或者用戶自己設置了其他公共DNS伺服器，都有可能導致返回的IP不是最優的
2. 如何準確分流
基於DNS的附載均衡方案，有一個很大的弊端就是流量分配不均
- ISP DNS: DNS解析結果被緩存，一個DNS請求可能對應到成千上百個服務請求
- 缺乏廣泛的edns-client-subnet支持: 這不僅會導致流量的跨地區訪問，還會嚴重影響用戶體驗
    - 用戶手動設置DNS伺服器，得不到最優IP解析
    - 小ISP使用其他異地ISP的DNS，得不到最優IP解析
由於服務提供者，很難控制用戶自己的DNS設置以及廣大DNS服務提供者對edns-client-subnet的支持，如何調整流量就必須從服務端進行了
- 透過對balancer信息流新增一個環節: global balancer根據每個集群的容量和已有請求進行集群間的流量遷移
   - 這對GLSB系統有兩個需求
   - 1. local balancer上報的數據有新的要求，不僅要上報本地集群的容量，還要對收到的流量進行上報，方便global blancer調配流量
   - 2. local balancer要能夠轉發遠大於本地集群容量的請求，要有足夠能力轉發多餘的請求到其他集群
這其實是在server端建構一個反饋迴路，local/global balancer可以根據集群容量、負載進行流量調配，消除了由於DNS調度導致的熱點集群問題，同時可以透過收集數據確認集群健康度

- 另一種可行的方案是，伺服器在收到用戶端請求時，判斷用戶是否在訪問最優的集群，如不是最優集群就重新定向用戶到最近/最優的集群
    - 利用伺服器進行RTT的對比，如果RTT大於一訂的閥值就像自己的authoritative DNS提交該客戶IP查最優結果，然後基於該結果重新定向FQDN的record
3. 如何快速切流
預設發生事故時，如何在事故發生當下快速切走流量，將用戶的影響降到最低; 基於DNS的切分流機制會有以下幾點風險
- 客戶端的DNS緩存，ie 瀏覽器、作業系統
- ISP DNS或公共DNS服務的緩存
- 不遵循DNS TTL的DNS服務或客戶端
以上幾點會致使，即便第一時間更新authoritative DNS(拿掉有問題的)後仍然有可能致使請求發送到故障群集(note:故障群集如果load balancer可以用則不在此討論內，因為loadbalance還可以再透過check health把請求導走，這邊討論load balancer也故障)

# 透過anycast來解決這個問題
要解決這個問題，最好的方案是通過anycast，每個集群通過BGP對外通告同樣的VIP，網際網路上的路由器會根據最終通根據通告的VIP距離判斷路由的優先級。所有用戶對www.example.com的DNS請求都會返回同樣的VIP位址，但是不同區域用戶對VIP的請求會被路由到各自最近的集群

如果當某個集群出現故障時，該集群對外通告的VIP會被撤回，路由更新之後，之前該集群服務的用戶請求會被自動路由到次優集群，這對用戶來說都是透明的，但是如果提供的服務是有狀態的，會導致狀態丟失(e.g. youtube視頻播放中斷)

# 透過Dyn Anycast解決問題
另一種方法是通過BGP的community為集群的IP位址設置主備路由，備份路由的目的地是另外一個集群

authoritative DNS根據用戶所在區域和集群容量信息返回集群的VIP，正常請求下，該VIP的數據包會被路由到本集群，當該集群故障時，備份路由生效，從而流量會被路由到其他健康的集群，同樣會對有狀態服務造成影響

# 延遲控制系統
當一個GSLB系統具備了內部集群間的流量調度功能時，形成一個反饋閉環境，整個GSLB系統就具備了控制系統的特徵，而且還是具有延遲的控制系統
- 信息流動過程
- 1. 本地集群的各個服務項local balancer匯報當前負載
- 2. 向global balancer匯報所有本地服務的負載和容量(服務owner提前配置)
- 3. global balancer收集到所有local balancer的上報之後計算出如何分配集群間的流量
- 4. global balancer下發流量調配指示;更新authoritative DNS
- 5. local balancer調整流量分配
- 6. 回到步驟1.
然而整個過程不是瞬間完成的：本地服務每10秒上報一次負載，本地balancer每5秒上報一次，本地balancer可以在上報的RPC請求結果中拿到流量分配指示

由於global balancer不可能實時計算所有集群所有服務的流量分配情況，所以本地balancer拿到的分配指示和本次上報是沒有關係的，流量分配指示是根據歷史數據計算出來的。。。


# refer
https://www.digitimes.com.tw/tw/dt/n/shwnws.asp?cnlid=&id=0000123944_1ju8xdyl51almb3nbf11j
https://kknews.cc/zh-tw/tech/g24rjz9.html
https://wellmars.wordpress.com/2012/02/15/%E6%B7%BA%E8%AB%87-gslb-global-server-load-balance%E5%BB%A3%E5%9F%9F%E5%BC%8F%E8%B2%A0%E8%BC%89%E5%B9%B3%E8%A1%A1/