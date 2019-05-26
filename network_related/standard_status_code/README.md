# 筆記HTTP Status Code代表意思
當瀏覽器接收到伺服器的回應後，都會自動去判讀網頁的狀態，其中Http Status常見代碼如下，


# 大項分類
- 1xx(Informational) : The request was received, continuing process
- 2xx(Successful) : The request was successfully received, understood, and accepted
- 3xx(Redirection) : Further action needs to be taken in order to complete the request
- 4xx(Client Error) : The request contains bad syntax or cannot be fullfilled
- 5xx(Server Error) : The server failed to fullfill an apparently valid request

# 細項分類 1xx 資訊
表示client端的請求已經被接收，需要繼續處理。大多都是臨時回應，通常只包含狀態行和某些可選的回應header資訊，並以空行結束。另外，由於HTTP/1.0時沒有定義任何1xx的Status Code，所以除非在某些試驗條件下，Server通常不會向client發送1xx的回應

- 100 : 當Server收到請求的header的時候，Server會告知client端請求正在繼續被執行。如果傳送的請求帶有request body，當請求完成時Server在向client傳送的完成請求中會夾帶一個Expect: 100-continue的header

- 101(Switching Protocols) : 當Server端收到client端的請求header含有Upgrade時會通知client採用不同的協定來繼續溝通。在傳送玩這個回應最後的空行後，伺服器會切換到Upgrade header中定義的協定，通常會切換的協定有HTTP/2以及WebSocket

- 102(Processing) : WebDAV的請求可能包含許多sub request，需要花費較多的時間才能完成請求。此時會先發送102回應，避免client端顯示timeout，或者導致請求遺失

- 103(Early Hints) : Used to return some response headers before final HTTP message.


# 細項分類 2xx 成功回應
這系列的Status Code表示伺服器有確實接收到client的命令，理解而且接受

- 200(OK) : 伺服器回應成功

- 201(Created) : 請求已經被實現，而且有一個新的資源已經依據請求的需要而建立。假使需要的資源無法及時建立的話，會返回202 Accepted

- 202(Accepted) : 伺服器已經接受請求，但是尚未處理。也不能確定請求執行狀態是否成功

- 203(Non-Authoritative Information) : 伺服器是一個轉換代理伺服器(transforming proxy，例如Proxy)

- 204(No Content - Success) : 請求有得到正常回應，但是client端不需要更新其現有的頁面。204回應是可以被緩存的，在回應中應該要包含ETag的header及其信息。
> e.g. 在PUT請求中，進行資源更新，但是不需要改變當前展示給用戶的頁面，即返回204。反之，如果創造了新的資源，那麼返回201 Created。如果頁面需要更新以反應更新後的資源，那麼需要返回200。(Spec : RFC 7231, section 6.3.5: 204 No Content)

- 205(Reset Content) : 伺服器成功處理了請求，蛋沒有返回任何內容。與204回應不同，此類回應要請求者重設文件視圖

- 206(Partial Content) : 取得片段資料，Http Request中有的Range屬性，可以指定要取得哪一段Bytes數。(伺服器已經成功處理了部分GET請求。類似於FlashGet或者迅雷這類HTTP下載工具，都是使用此類回應實現斷點續傳或者將一個大文件分解為多個下載段同時下載)

- 207(Multi-Status WebDAV) : 代表之後的訊息體將是一個XML訊息，並且可以能依照之前子請求數量的不同，包含一系列獨立的回應程式碼

- 208(Already Reported WebDAV) : DAV繫節的成員已經在(多狀態)回應之前的部分被列舉，且未被再次包含

- 226(IM Used) : 伺服器已經半足了對資源的請求，對實體請求的一個或多個實體操作的結果表示

# 細項分類 3xx 導向回應
這類狀態馬代表需要用戶端採取進一步的操作才能完成。通常，這些狀態碼用來重新導向，後續的請求位址(重新導向目標)在本次回應的Location域中指明。如果後續的請求方法是使用GET或者HEAD時，用戶瀏覽器才可以在沒有用戶介入的情況下自動提交所需要的後續請求。

- 300(Multiple Choices) : 被請求的資源有一系燮可供選擇的回饋資訊
> 每個的有自己特定的位址和瀏覽器驅動的商議資訊。用戶或瀏覽器能夠自行選擇一個首選的位址進行重新導向。除非這是一個HEAD請求，否則該回應應當包括一個資源特性及位址的列表的實體，以便用戶或瀏覽器從中選擇最合適的重新導向位址。這個實體的格式由Content-Type定義的格式所決定。瀏覽器可能根據回應的格式以及瀏覽器自身能力，自動作出最合適的選擇。如果伺服器本身已經有了首選的回饋選擇，那麼在Location中應當指明這個回饋的URI；瀏覽器可能會將這個Location值作為自動重新導向的位址。此外，除非額外指定，否則這個回應也是可緩存的

- 301(Moved Permanently) : 目標網頁移到新網址(永久轉址)
> 被請求的資源已永久移動到新位址，並且將來任何對此資源的參照都應該使用本回應返回的若干個URI之一。如果可能，擁有連結編輯功能的用戶端應當自動把請求的位址修改為從伺服器回饋回來的位址。除非額外指定，否則這個回應也是可以緩存的。新的永久性的URI應當在回應的Location域中返回。除非這是一個HEAD請求，否則回應的實體中應當包含指向新的URI的位址以及簡短說明。note:對於某些用HTTP/1.0協定的瀏覽器，當他們傳送的POST請求得到一個301回應的話，接下來的重新導向請求將會變成GET

- 302(Found) : 暫時轉址
> 要求用戶端執行臨時重新導向(原始描述短語為Moved Temporarily)。由於這項的重新導向是臨時的，用戶端應當繼續向原有位址傳送以後的請求。只有在Cache-Control或Expires中進行了指定的情況下，這個回應才是可以緩存的。新的臨時性的URI應當在回應的Location域中返回。除非這是一個HEAD請求，否則回應的實體中應當包含指向新的URI的位址及簡短說明。note:雖然RFC 1945和RFC 2068規範不允許用戶端再重新導向時改變請求的方法，但是很多現存的瀏覽器將302回應視為303回應，並且使用GET方式存取在Location中的URI，無視原先的請求方法。因此Status Code 303和307被添加了進來，用以明確伺服器期待用戶端進行何種反應

- 303(See Other) : 對應目前請求的回應可以在另一個URI上被找到，當回應於POST(或PUT/ DELETE)接收到回應時，用戶端應該假定伺服器已經收到資料，並且應該使用單獨的GET訊息發出重新導向
> 這個方法的存在主要是為了允許油Status Code啟用的POST請求輸出重新導向到另一個新的資源。這個新的URI不是原始資源的替代參照。同時，303回應禁止被緩存。不過第二個請求(重新導向)可能被緩存。新的URI應當在回應的Location域中返回，除非這是一個HEAD請求，否則回應的實體中應當包含指向新的URI的位址以及簡短說明。note:HTTP/1.1版以前的瀏覽器不能正確理解303狀態。如果需要考慮與不能理解的瀏覽器之間互動，建議以Status Code 302做回應

- 304(Not Modified) : 已讀取過的圖片或網頁，由瀏覽器緩存(cache)中讀取
> 表示資源在由請求header中的If-Modified-Since或if-None-Match參數指定的這一版本之後，未曾被修改。在這種情況下，由於用戶端仍具有以前下載的副本，因此不需要重新傳輸資源

- 305(Use Proxy) : 被請求的資源必須通過指定的代理才能被存取。
> Location域中將給出指定的代理所在的URI資訊，接受者需要重複傳送一個單獨的請求，通過這個代理才能存取相應資源。只有源站(Origin site)才能建立305回應。note:許多HTTP client(像是Mozilla和Internet Explorer)都沒有正確處理這種狀態程式碼的回應，主要是出於安全考慮

- 306(Switch Proxy) : 後續請求應使用指定代理。note:在最新版的規範中，306代碼已經不再被使用

- 307(Temporary Redirect) : 在這種情況下，請求應該與另一個URI重複，但後續的請求應仍使用原始的URI。
> 與302相反，當重新發出原始請求時，不允許更改請求方法。例如，應該使用另一個POST請求來重複POST請求

- 308(Permanent Redirect) : 請求和所有將來的請求應該使用另一個URI重複
> 307和308重複302和301的行為，但不允許HTTP方法更改。例如，將表單提交給永久重新導向的資源可能會順利進行

# 細項分類 4xx 非正常請求回應
這類的狀態碼代表了用戶端看起來可能發生了錯誤，妨礙了伺服器的處理。除非回的是一個HEAD請求，否則伺服器就應該返回一個解釋目前錯誤狀況的實體，以及這是臨時的還是永久性的狀況。note:如果錯誤發生在用戶端傳送資料時，那麼使用TCP的伺服器實現應當仔細確保在關密用戶端與伺服器隻雞的連接之前，用戶端已經收到了包含錯資訊的風包。如果錯誤發生在，用戶端在收到TCP server回傳給client端一個RST的封包時，需要清除client端上的緩存，以免錯誤資料被再度送到TCP server而干擾應用程式的讀取

- 400(Bad Request) : 由於明顯的用戶錯誤(例：格式錯誤的請求語法，無效的請求訊息或欺騙性路由請求)，伺服器不能也不會處理該請求

- 401(Unauthorized) : 需身份驗證，如SSL key or htaccess password。該請求需要用戶驗證，該回應必須包含一個適用於被請求資源的WWW-Authenticate header用以詢問用戶資訊。client端可以重複提交一個包含恰當的Authorization憑證。如果目前請求已經包含了Authorization憑證，那麼401回應代表著伺服器驗證已經拒絕了那些憑證。note:如果網站禁止IP位址時，有些網站以Status Code 401表示，該特定位址被拒絕存網站

- 402(Payment Required) : 表示為了將來可能的需求而預留的。(不常使用)

- 403(Forbidden) : 沒有權限讀取，可能是IP被阻檔或是伺服器限制。note:與401不同的是，身份驗證並不能提供任何幫助，而且這個請求也不應該被重複提交。如果伺服器不希望用戶端獲得任何資訊也可以用404回應

- 404(Not Found) : 伺服器未找到目標網址，檔案不存在。
> 請求所希望得到的資源未被在伺服器上發現。假如是是永久的，伺服器應當使用410來告知，舊資源因為內部組織機制問題，已經永久的不可用。

- 405(Method Not Allowed) : 請求中指定的請求方法不能被用於請求相應的資源。返回一個Allow header資訊用以表示目前資源能夠接受的請求方法的列表
> 例如，需要透過POST呈現資料的表單上的GET請求，或唯獨資源上的PUT請求；鑑於PUT，DELETE方法會對伺服器上的資源進行操作，因而絕大部分的網頁伺服器都不支援，或者在預設組態下不允許上述請求方法，通常會對此類請求返回405錯誤

- 406(Not Acceptable) : 請求的資源的內容特性無法滿足請求header中的條件，因而無法生成response body，該請求不可接受

- 407(Proxy Authentication Required) : 與401回應類似，只不過用戶端必須在代理伺服器上進行身份驗證。代理伺服器必須返回一個Proxy-Authenticate用以進行身份詢問

- 408(Request Timeout) : Client Request timeout，請求超時
> 根據HTTP規範，用戶端沒有在伺服器預備等待的時間內完成一個請求的傳送，用戶端可以隨時再次提交這一請求而無需更改

- 409(Conflict) : 因為請求存在衝突無法處理該請求，例如多個同步更新之間的編輯衝突

- 410(Gone) : 表示該請求的資源已經不再可用。通常是指資源被有意地刪除並且資源被清除時才使用
> 但是大多的伺服器為了方便還是使用404居多

- 411(Length Required) : 沒有指定content-length，使用POST傳送參數時，必須指定參數的總長度

- 412(Precondition Failed) : 伺服器在驗證請求的header中給出的pre-condition，沒能滿足其中的一個或多個

- 413(Request Entity Too Large) : 該請求提交的實體資料大小超過了伺服器願意或者能夠處理的範圍，因此伺服器拒絕處理目前的請求

- 414(Request-URI Too Long) : 請求的URI太長導致伺服器拒絕處理
> 請求的URI長度超過了伺服器能夠解釋的長度，因此伺服器拒絕該請求；e.g.本應使用POST方法的表單提交變成了GET方法or重新導向URI過多次，把每次舊的URI作為新的URI一部份在做請求；用戶端正在嘗試利用某些伺服器的安全漏洞攻擊伺服器。

- 415(Unsupported Media Type) : 對於目前請求的方法和所請求的資源，請求中提交的protocol media type不是伺服器所支援的格式
> e.g.用戶端將圖像檔案上傳格式為svg，但伺服器要求圖像使用上傳格式為jpg

- 416(Requested Range Not Satisfiable) : 用戶端已經要求檔案的一部份(Byte serving)，但伺服器不能提供該部分 `curl -r 0-199 http://example.com`
> https://ec.haxx.se/http-ranges.html
> https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Range_requests

- 417(Expectation Failed) : 在請求header Expect中指定的預期內容無法被伺服器滿足

- 418(I'm a teapot) : 彩蛋狀態碼...

- 420(Enhance Your Claim) : Twitter Search與Trends API在用戶端被限速的情況下返回

- 421(Misdirected Request) : 該請求針對的事物法產生回應的伺服器(e.g.連接重用))

- 422(Unprocessable Entity ) : WebDAV用，請求格式正確，但是由於含有語意錯誤，無法回應

- 423(Locked) : 目前資源被鎖定

- 424(Failed Dependency) : 由於之前的某個請求發生的錯誤，導致目前請求失敗
> e.g. PROPPATCH

- 425(Unordered Collection) : 在WebDAV Advanced Collections Protocol中定義，但Web Distributed Authoring and Versioning(WebDAV) Ordered Collections Protocol中並不存在

- 426(Upgrade Required) : 用戶端應當切換到TLS/1.0，並在HTTP/1.1 Upgrade header中給出

- 428(Precondition Required) : 原伺服器要求該請求滿足一定條件
> 這是防止"未更新"問題，即用戶端讀取(GET)一個資源的狀態，更改它並將它寫(PUT)回伺服器時，第三方已經在伺服器取得了該資源，會有重複寫入的衝突

- 429(Too Many Requests) : Requests太多
> 用戶在給定的時間內傳送了太多的請求。旨在用於網路限速(rate limit)

- 431(Request Header Fields Too Large) : 伺服器不願處理請求，因為一個或多個header的欄位過大。note: header-key 不是header value

- 444(No Response) : Nginx上HTTP伺服器擴展
> 伺服器不向客戶端返回任何資訊，並關閉連結(有助於阻止惡意軟體)

- 450(Blocked by Windows Parental Controls) : (Microsoft)HTTP阻止的測試碼

- 451(Unavailable For Legal Reasons) : 該存取因法律的要求而被拒絕

- 494(Request Header Too Large) : 在Status Code 431提出之前Nginx上使用的擴充HTTP程式碼

# 細項分類 5xx 無法回應
表示伺服器無法完成明確有效的請求。這類Status Code代表伺服器在處理請求的過程中有錯誤或者異常狀態發生，或是伺服器的資源不足已完成對應的請求處理。除非這是一個HEAD請求，否則伺服器應當包含一個解釋目前錯誤狀態以及這個狀況是臨時的還是永久的解釋資訊。


- 500(Internal Server Error) : 通用錯誤訊息。伺服器發生錯誤，遇到非預期狀況，不法完成對請求的處理，也無法給出具體錯誤資訊

- 501(Not Implemented) : 伺服器不支援目前請求所需要的某個功能；伺服器無法辨識請求的方法，並且無法支援其對任何資源(API)的請求

- 502(Bad Gateway) : 作為閘道器或者代理工作的伺服器嘗試執行請求時，從上游伺服器接收到無效的回應

- 503(Service Unavailable) : 伺服器當掉；由於臨時的伺服器維護或者過載，伺服器目前無法處理請求。如果能夠預計伺服器返回正常的時間，會在回應中加入一個Retry-After的header表明多久後可以重複嘗試請求

- 504(Gateway Timeout) : gateway timeout；作為閘道器或者代理伺服器，執行請求時未能及時從上游伺服器(URI標識出的伺服器，e.g. HTTP/FTP/LDAP)或者輔助伺服器(e.g. DNS)收到回應。note:某些代理伺服器在DNS查詢超時的時候返回的Status Code為400或500錯誤

- 505(HTTP Version Not Supported) : 不支持此HTTP版本；伺服器不支援，或者拒絕支援在請求中所使用的HTTP版本

- 506(Variant Alos Negotiates) : 由"透明內容協商協定"擴充，代表伺服器存在內部組態錯誤，被請求的協商變元資源被組態為在透明內容協商中使用自己，因此在一個協商處理中不是一個合適的重點

- 507(Insufficient Storage) : 伺服器無法儲存完成請求所必需的內容；通常這種狀況都會被認為是臨時的

- 508(Loop Detected) : 伺服器在處理請其實陷入無窮回權(可以代替Status Code 208)

- 510(Not Extended) : 取得資源所需要的策略並沒有被滿足

- 511(Network Authentication Required) : 用戶端需要進行身份驗證才能獲得網路存取權限，旨在限制用戶存取特定網路；e.g. 連接WIFI熱點時的強制網路門戶

# Un Official Status Code
- 420(Enhance Your Claim) : 早期Twitter API會在短時間送出太多請求，現在已經被Status Code 429取代

- 498(Invalid Token) & 499(Token Required) : 以前一個叫做ArcGIS for Server的系統回應的Status Code，已經被401 Unauthorized取代

- 520(Unknown Error) : Cloudflare針對未知的錯誤所回應的Status Code

- 521(Web Server Is Down) : 目標伺服器掛了，一般會用在一些CDN上會出現；e.g. Cloudflare

# 專有名詞縮寫
- HTTP : Hypertext Transfer Protocol
- RFCs : Request for Comments

# refer
https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Status/204
https://www.puritys.me/docs-blog/article-45-Http-status-%E7%8B%80%E6%85%8B-404-304.html
https://en.wikipedia.org/wiki/WebDAV