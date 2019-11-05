# Intro
常見的四種POST方法
1. application/x-www-form-urlencoded
2. multipart/form-data
3. application/json
4. text/xml


# 前言
HTTP/1.1 協議規定的 HTTP 請求方法有 OPTIONS、GET、HEAD、POST、PUT、DELETE、TRACE、CONNECT 這幾種。其中 POST 一般用來向服務端提交數據。

HTTP 協議是以 ASCII 碼傳輸，建立在 TCP/IP 協議之上的應用層規範。規範把 HTTP 請求分為三個部分：狀態行、請求頭、消息主體。類似於下面這樣
```js
<method> <request-URL> <version>
<headers>
<entity-body>
```
協議規定 POST 提交的數據必須放在消息主體（entity-body）中，但協議並沒有規定數據必須使用什麽編碼方式。實際上，開發者完全可以自己決定消息主體的格式，只要最後發送的 HTTP 請求滿足上面的格式就可以。

但是，數據發送出去，還要服務端解析成功才有意義。一般服務端語言如 php、python 等，它們的 framework，都內置了自動解析常見數據格式的功能。

服務端通常是根據請求頭（headers）中的 Content-Type 字段來獲知請求中的消息主體是用何種方式編碼，再對主體進行解析。

所以說到 POST 提交數據方案，包含了 Content-Type 和消息主體編碼方式兩部分。


# Content-Type: $POST_CONTENT_TYPE
### application/x-www-form-urlencoded
瀏覽器的原生 form 表單，如果不設置 enctype 屬性，那麽最終就會以 application/x-www-form-urlencoded
```
POST http://www.example.com HTTP/1.1
Content-Type: application/x-www-form-urlencoded;charset=utf-8
title=test&sub%5B%5D=1&sub%5B%5D=2&sub%5B%5D=3
```

### multipart/form-data
我們使用表單上傳文件時，必須讓 form 的 enctyped 等於這個值
```
POST http://www.example.com HTTP/1.1
Content-Type:multipart/form-data; boundary=----WebKitFormBoundaryrGKCBY7qhFd3TrwA
------WebKitFormBoundaryrGKCBY7qhFd3TrwA
Content-Disposition: form-data; name="text"
title
------WebKitFormBoundaryrGKCBY7qhFd3TrwA
Content-Disposition: form-data; name="file"; filename="chrome.png"
Content-Type: image/png
PNG ... content of chrome.png ...
------WebKitFormBoundaryrGKCBY7qhFd3TrwA--
```
消息主體裏按照字段個數又分為多個結構類似的部分，每部分都是以 –boundary 開始，緊接著內容描述信息，然後是回車，最後是字段具體內容（文本或二進制）。如果傳輸的是文件，還要包含文件名和文件類型信息。消息主體最後以 –boundary– 標示結束。


### application/json
用來告訴服務端消息主體是序列化後的 JSON 字符串。由於 JSON 規範的流行，除了低版本 IE 之外的各大瀏覽器都原生支持 JSON.stringify
```
POST http://www.example.com HTTP/1.1
Content-Type: application/json;charset=utf-8
{"title":"test","sub":[1,2,3]}
```

### text/xml
它是一種使用 HTTP 作為傳輸協議，XML 作為編碼方式的遠程調用規範。
```
POST http://www.example.com HTTP/1.1
Content-Type: text/xml
<?xml version="1.0"?>
<methodCall>
<methodName>examples.getStateName</methodName>
<params>
<param>
<value><i4>41</i4></value>
</param>
</params>
</methodCall>
```


# refer:
- https://www.itread01.com/content/1536302734.html
- https://gist.github.com/jim0409/b0cab4036771aab598d10dea252c3854