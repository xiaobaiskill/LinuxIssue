# HTTP - Hyper Text Transfer Protocol
HTTP中文為超文本傳輸協議，採用request/response的模式渲染出網頁內容;
- 就整個網路傳輸而言，包括message-header和message-body兩個部分
- 首先傳遞message-header，即http header消息
- http header通常被分為4個部分:
  - general header
  - request header
  - response header
  - entity header
但是這種分法就理解而言，感覺界限不太明確，所以大體上可以先分成request header和response header

# Reqeust部分
1. Accept: 指定客戶端能夠接收的內容類型 `e.g. Accept: text/plain, text/html`
2. Accept-Charset: 瀏覽器可以接受的字符編碼集 `e.g. Accept-Charset: iso-8859-5`
3. Accept-Encoding: 指定瀏覽器可以支持的web服務器返回內容壓縮編碼類型 `e.g. Accept-Encoding: compress, gzip`
4. Accept-Language: 瀏覽器可接受的語言 `e.g. Accept-Language: en, zh`
5. Accept-Ranges: 可以請求網頁實體的一個或者多個子範圍字段 `e.g. Accept-Ranges: bytes`
6. Authorization: HTTP授權的授權證書 `e.g. Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==`
7. Cache-Control: 指定request和response所應遵循的緩存機制 `e.g. Cache-Control: no-cache`
8. Connection: 表示是否需要持久連接(HTTP 1.1默認進行持久連接) `e.g. Connection: close`
9. Cookie: HTTP請求發送時，會把存在該請求域名下的所有cookie值一起發送給web server `e.g. Cookie: $Version=1; Skin=new`
10. Content-Length: 請求的內容長度 `e.g. Content-Length: 348`
11. Content-Type: 請求與實體對應的MIME信息 `e.g. Content-Type: application/x-www-form-urlencoded`
12. Date: 請求發送的日期和時間 `e.g. Date: Tue, 15 Nov 2010 08:12:31 GMT`
13. Expect: 請求的特定的服務器行為 `Expect: 100-continue`
14. From: 發出請求的用戶的Email `e.g. From: user@email.com`
15. Host: 指定請求的用戶的Email `e.g. Host: www.zcmhi.com`
16. If-Match: 只有請求內容與實體相匹配才有效 `e.g. If-Match: "737060cd8c284d8af7ad3082f209582d"`
17. *If-Modified-Since: 如果請求的部分在指定時間之後被修改則請求成功，未被修改則返回304 status code `e.g. If-Modified-Since: Sat, 29 Oct 2010 19:43:31 GMT`
18. *If-None-Match: 如果內容未改變返回304 status code，參數為服務器先前發送的Etag，與服務器回應的Etag比較判斷是否改變 `e.g. If-None-Match: "737060cd8c284d8af7ad3082f209582d"`
19. *If-Range: 如果實體未改變，服務器發送客戶端丟失的部分，否則發送整個實體。參數也為Etag `e.g. If-Range: "737060cd8c284d8af7ad3082f209582d"`
20. *If-Unmodified-Since: 只在實體在指定時間之後未被修改才請求成功 `e.g. If-Unmodified-Since: Sat, 29 Oct 2010 19:43:31 GMT`
21. Max-Forwards: 限制信息通過代理和gateway傳送的時間 `e.g. Max-Forwards: 10`
22. Pragma: 用來包含實現特定的指令 `e.g. Pragma: no-cache`
23. Proxy-Authorization: 連接到代理的授權證書 `e.g. Proxy-Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==`
24. Range: 只請求實體的一部份，指定範圍 `e.g. bytes=500-999`
25. Referer: 先前網頁的地址，當前請求網頁緊隨其後，即上一頁 `e.g. Referer: http://www.zcmhi.com/archives/71.html`
26. TE: 客戶端願意接收的傳輸編碼，並通知服務器接受尾加頭信息 `e.g. TE: trailers,deflate;q=0.5`
27. Upgrade: 向服務器指定某種特殊傳輸協議，以便服務器進行協議轉換 `e.g. Upgrade: HTTP/2.0, SHTP/1.3, IRC/6.9, RTA/x11`
28. User-Agent: User-Agent的內容包含發出請求的用戶信息 `e.g. User-Agent: Mozilla/5.0(Linux; X11`
29. Via: 通知中間網關或代理服務器地址，通信協議 `e.g. Via: 1.0 fred, 1.1 nowhere.com (Apache/1.1)`
30. Warning: 關於消息實體的警告信息 `e.g. Warn: 199 Miscellianeous warning`


# Response部分
1. Accept-Ranges: 表明服務器是否支持指定範圍請求及哪種類型的分段請求 `e.g. Accept-Ranges: bytes`
2. Age: 從原始服務器到代理緩存形成的估算時間(以秒計算，恆正) `e.g. Age:12`
3. Allow: 對某網路資源的有效的請求行為，不允許則返回405 `e.g. Allow: GET, HEAD`
4. Cache-Control: 告訴所有的緩存機制是否可以緩存及哪種類型 `e.g. Cache-Control: no-cache`
5. Content-Encoding: web服務器支持的返回內容壓縮編碼類型 `e.g. Content-Encoding: gzip`
6. Content-Language: response的語言 `e.g. Content-Language: en,zh`
7. Content-Length: response的長度 `e.g. Content-Length: 348`
8. Content-Location: 請求資源可替代的備用的另一地址 `Content-Location: /index.htm`
9. Content-MD5: 返回資源的MD5校驗值 `e.g. Content-MD5: Q2hlY2sgSW50ZWdyaXR5IQ==`
10. Content-Range: 在整個response中"本體"的字節位置 `e.g. Content-Range: bytes 21010-47021/47022`
11. Content-Type: 返回內容的MIME類型 `e.g. Content-Type: text/html; charset=utf-8`
12. Date: 原始服務器消息發出的時間 `e.g. Date: Tue, 15 Nov 2010 08:12:31 GMT`
13. ETag: 請求變量的實體標籤的當前值 `e.g. ETag: "737060cd8c284d8af7ad3082f209582d"`
14. Expires: response過期的日期和時間 `e.g. Expires: Thu, 01 Dec 2010 16:00:00 GMT`
15. Last-Modified: 請求資源的最後修改時間 `e.g. Last-Modified: Tue, 15 Nov 2010 12:45:26 GMT`
16. Location: 用來重新定向接收方的非請求URL的位置來完成請求或標示新的資源 `e.g. Pragma: no-cache`
17. Pragma: 包括實現特定的指令，他可以應用到響應鏈上的任何接收方 `e.g. Pragma: no-cache`
18. Proxy-Authenticate: 它指出認證方案和可應用到代理的該URL上的參數 `e.g.Proxy-Authenticate: Basic`
19. refresh: 應用於重定向或一個新的資源被創造，在5秒之後重定向(由網景提出，被大部分瀏覽器支持) `e.g. Refresh: 5; url=http://www.zcmhi.com/archives/94.html`
20. Retry-After: 如果實體暫時不可取，通知客戶端在指定時間之後再次嘗試 `e.g. Retry-After:120`
21. Server: web server軟件名稱 `e.g. Server: Apache/1.3.27 (Unix)(Red-Hat/Linux)`
22. Set-Cookie: 設置Http Cookie `e.g. Set-Cookie: UserID=JohnDoe; Max-Age=3600; Version=1`
23. Trailer: 指出頭域在分塊傳輸編碼的尾部存在 `e.g. Trailer: Max-Forwards`
24. Transfer-Encoding: 文件傳輸編碼 `e.g. Transfer-Encoding: chunked`
25. Vary: 告訴下游代理是使用緩存響應還是從原始服務器請求 `e.g. Vary: *`
26. Via: 告知代理客戶端響應是通過哪裡發送的 `e.g. Via: 1.0 fred, 1.1 nowhere.com (Apache/1.1)`
27. Warning: 警告實體可能存在的問題 `e.g. Warning: 199 Miscellaneous warning`
28. WWW-Authenticate: 表明客戶端請求實體應該使用的授權方案 `e.g. WWW-Authenticate: Basic`


# refer
https://kb.cnblogs.com/page/92320/