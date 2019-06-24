# HSTS (HTTP Strict Transport Security)
是一套由網際網路工程任務組發布的網際網路安全策略機制，旨在`HTTP嚴格傳輸安全`


# HTTPS (HTTP Secure)
一般使用者在HTTPS網站的訪問過程，通常訪問一個網站時，只在瀏覽器輸入網站地址，不會加入schema(協議名)
比如，訪問google.com，會輸入`google.com`，而非`https://google.com`，所以連結還是會先到`http://google.com`再透過302跳轉到https://google.com

```
HTTPS 溝通過程

browser                                  Server
<-------------------------------------------> TCP 三次握手
<-------------------------------------------> 302 http -> https
<-------------------------------------------> TCP 三次握手
Client Hello -------------------------------------------->
<--------------------------------------------- Server Hello 
<--------------------------------------------- Certificate
```
- 整個過程有兩個問題
1. 整個通信過程中的前兩個RT是沒有意義的
2. 使用了不安全的HTTP通信，難保第一個請求含有敏感數據

HSTS的出現就是解決這些問題的。HSTS的作用除了節省HTTPS通信RT和強制使用HTTPS，還包括
1. 阻止基於SSL Strip(SSL剝離)的中間人攻擊
2. 萬一證書有錯誤，則顯示錯誤，用戶不能回忽略警告

# 內容
HSTS的作用是強制用戶端(如瀏覽器)使用HTTPS與伺服器建立連結。伺服器開啟HSTS的方法是，當用戶端通過HTTPS發出請求時，在伺服器返回的`超文字傳輸協定(HTTP)`回應header中包含`Strict-Transport-Security`欄位。非加密傳輸時設定的HSTS欄位無效
```
e.g.
https://example.com/的回應header中有Strict-Transport-Security: max-age=31536000; includeSubDomains

- 這意味著兩點:
    1. 在接下來的315360000秒(一年)中，瀏覽器向example.com或其子域名傳送HTTP請求時，必須採用HTTPS來發起連結。比如，用戶點選`超連結`或在網址輸入
        > http://www.example.com/，瀏覽器應當自動將http轉寫成https，然後直接向https://www.example.com傳送請求
    2. 在接下來的一年中，如果example.com伺服器傳送的TLS憑證無效，用戶不能忽略瀏覽器警告，繼續存取網站
```

# 作用
HSTS可以用來抵禦SSL剝離攻擊。SSL剝離攻擊是中間人攻擊的一種，由Moxie Marlinspike於2009年發表`New Tricks For Defeating SSL In Practice`
> SSL玻璃的實施方法是阻止瀏覽器與伺服器建立HTTPS連接
他的前提是用戶很少直接在網址輸入`https://`，用戶總是通過點選連結或是3XX重新導向，從HTTP頁面進入HTTPS頁面。所以攻擊者可以在用戶存取HTTP頁面時替換所有的`https://`開頭的連結為`http://`，達到阻止HTTPS的目的

- HSTS可以很大程度上解決SSL剝離攻擊，因為只要瀏覽器曾經與伺服器建立過一次安全連結，之後瀏覽器會強制使用HTTPS，即使連結被換成了HTTP
- 另外，如果中間人使用自己的`自簽憑證`來進行攻擊，瀏覽器會給出警告，但是許多用戶會忽略警告。HSTS解決了這一問題，一但伺服器傳送了HSTS欄位，將不再允許用戶忽略警告

# 不足
用戶首次存取某網站是不受HSTS保護的。這是因為首次存取時，瀏覽器還未收到HSTS，所以仍有可能通過明文HTTP來存取
- 解決這不足目前有兩種方案
    - 一是瀏覽器偏好設定HSTS域名列表，google chrome/ firefox/ internet explorer/ microsoft edge目前已實現這方案
    - 二是將HSTS資訊加入到域名系統中，但這需要保證DNS的安全性，也就是需要部署`域名系統安全擴充`

由於HSTS會再依定時間後失效(依據max-age指定)，所以瀏覽器是否強制HSTS策略取決於目前系統時間。部分作業系統經常通過`網路時間協定`更新系統時間，如Ubuntu每次連接網路時、OS XLion每隔9分鐘會自動連結時間伺服器。
- 攻擊者可以通過偽造NTP資訊，設定錯誤時間來繞過HSTS
    - 解決方法是認證NTP資訊，或者禁止NTP大幅度增減時間，比如windows 8每七天更新一次時間，並且要求每次NTP設定的時間與目前時間不得超過15小時

# HSTS preload list
HSTS preload list是Chrome瀏覽器中的HSTS預載入列表，在該列表中的網站，使用Chrome瀏覽器訪問時，會自動轉成HTTPS

# 如何加入HSTS preload list?
具體要滿足的條件列於`https://hstspreload.appspot.com`網站
1. 有效的證書(如果使用SHA-1證書，必須是2016年前就會過期的)
2. 將所有的HTTP流量重新定向到HTTPS
3. 確保所有子域名啟用HTTPS，特別是www子域名

同時輸出的HSTS response header需要滿足以下條件:
1. max-age至少需要18週，10886400秒
2. 必須指定includeSubDomains參數
3. 必須支持preload參數
所以一個典型滿足HSTS preload list的reponse header為: add_header Strict-Transport-Security: max-age=10886400; includeSubDomains;preload;

# refer
https://zh.wikipedia.org/wiki/HTTP%E4%B8%A5%E6%A0%BC%E4%BC%A0%E8%BE%93%E5%AE%89%E5%85%A8
https://blog.wilddog.com/?page_id=1493
https://free.com.tw/hsts-preload-list/
https://hstspreload.org/

# 手動清除google chrome的HSTS設定
https://blog.bennyling.cc/362/clear-google-chrome-hsts-setting/