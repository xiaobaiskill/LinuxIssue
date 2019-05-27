# Cross Origin Resource Sharing 跨來源資源共用
跨來源資源共用(Cross-Origin Resource Sharing(CORS))是一種使用額外HTTP標頭，另目前瀏覽網站的使用者代理取得存取其他來源(網域)伺服器特定資源權限的機制。
當使用者代理請求一個不是目前文件來源，例如來自不同網域(domain)、通訊協定(protocol)或通訊埠(port)的資源時，會建立一個跨來源HTTP請求(cross-origin HTTP request)


# 範例
http://domain-a.com裡面的HTML需要載入一個來自http://domain-b.com/image.jpg的圖片。現今網路上許多頁面所載入的資源，如css/image/script都來自於所在位置分離的網域，如傳遞網路(content delivery networks, CDN)


# 規範
基於安全考量，程式碼所發出的跨來源HTTP請求會受到限制。例如XMLHttpRequest及Fetch都遵守同源政策(same-origin policy)。這代表網路應用程式所使用的API除非使用CORS標頭，否則只能請求與應用程式相同網域的HTTP資源


# CORS相關header
- Access-Control-Allow-Origin
Indicates whether the response can be shared；表示可以回應的網域

- Access-Control-Allow-Credentials
Indicates whether the response to the request can be exposed when the credentials flag is true；當header的值帶true時，表示可以回應一些憑證信任相關的資料

- Access-Control-Allow-Headers
Used in response to a preflight request to indicate which HTTP headers can be used when making the actual request；用於預檢請求，在實際發出請求前先確認哪些HTTP headers可以被使用

- Access-Control-Allow-Methods
Specifies the method or methods allowed when accessing the resource in response to a preflight request；指定請求訪問時可以使用的方法

- Access-Control-Expose-Headers
Indicates which headers can be exposed as part of the response by listing their names；宣告可以放在回應請求的headers

- Access-Control-Max-Age
Indicates how long the results of a preflight request can be cached；表示可以緩存預檢請求的時間

- Access-Control-Request-Headers
Used when issuing a preflight request to let the server know which HTTP headers will be used when the actual request is made；表示哪些headers是可以在預檢請求時使用的

- Access-Control-Request-Method
Used when issuing a preflight request to let the server know which HTTP method will be used when the actual request is made；表示哪些請求方法是可以在預檢請求時使用的

- Origin
Indicates where a fetch originates from；指示提取源的位置

- Timing-Allow-Origin
Specifies origins that are allowed to see values of attributes retrieved via features of the Resource Timing API, which would otherwise be reported as zero due to cross-origin restrictions.

- X-Permitted-Cross-Domain-Policies
Specifies if a cross-domain policy-file (XML) is allowed. The file may define a policy to grant web clients, such as Adobe Flash Player or Adobe Acrobat (e.g. PDF), permission to handle data across domains.


# 本機模擬跨域名請求
用docker開啟三台nginx並且指定不同的內網ip
```
修改/etc/host
TEST.COM  192.168.0.1
TEST.COM  192.168.0.2
TEST.COM  192.168.0.3
```
分別反向代理不同的api請求，並且在請求中嘗試呼叫跨域名api資源

# 透過nginx反向代理解決跨域名請求
> 增加header 'Access-Control-Allow-Origin' '*'

# refer
https://developer.mozilla.org/zh-TW/docs/Web/HTTP/CORS
https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers
https://blog.csdn.net/l1028386804/article/details/79488328
https://www.cnblogs.com/morethink/p/6628757.html