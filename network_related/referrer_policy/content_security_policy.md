# Content Security Policy
content_security_policy主要是用來定義頁面可以加載哪些資源，減少XSS攻擊的發生

Chrome Extension已經引入CSP，通過`content_security_policy`來定義，一些現代瀏覽器也支持通過response header定義CSP

# 瀏覽器兼容性
```
response_header| Chrome | Firefox | Safari | IE
Content-Security-Policy
X-Content-Security-Policy
x-Webkit-CSP
```

# 如何使用
要使用CSP，只需要服務端輸出一個response header如
> Content-Security-Policy: default-src 'self'

`default-src`是CSP指令，多個指令之間用英文分割; `'self'`是指令值，多個指令值用英文空格分割

# 指令/ 指令值範例/ 說明
- default-src: 'self', cnd.a.com; 定義針對所有類型(js, image, css, web font, ajax 請求，iframe，多媒體等)資源的默認加載策略，某類型資源如果沒有單獨定義策略，就使用默認的
- script-src: 'self', js.a.com; 定義針對JavaScript的加載策略
- style-src: 'self', css.a.com; 定義針對樣式的加載策略
- img-src: 'self', img.a.com; 定義針對圖片的加載策略
- connect-src: 'self'; 針對Ajax、WebSocket等請求的加載策略。不允許的情況下，瀏覽器會回覆一個400的status code
- font-src: font.a.com; 針對WebFont的加載策略
- object-src: 'self'; 針對<object>、<embed>或<applet>等標籤引入的flash等插件的加載策略
- media-src: media.a.com; 針對<audio>或<video>等標籤引入的HTML多媒體的加載策略
- frame-src: 'self'; 針對frame的加載策略
- sandbox: allow-forms; 對請求的資源啟用sandbox(類似於iframe的sandbox屬性)
- report-uri: /report-uri; 告訴瀏覽器如果請求的資源不被策略允許時，往哪個地址提供日誌訊息。如果想讓瀏覽器只會報日誌，不阻止內容，可以改用`Content-Security-Policy-Report-Only` header

指令值可以由下面這些弄戎組成：
```
指令值/ 指令示例/ 說明

empty/ img-src/ 允許任何內容
'none'/ img-src 'none'/ 不允許任何內容
'self'/ img-src 'self'/ 允許任何來在相同來源的內容(相同的協議、域名和端口)
data:/ img-src data:/ 允許`data:`協議(如base64編碼的圖片)
www.a.com/ img-src img.a.com/ 允許加載指定域名的資源
.a.com/ img-src a.com/ 允許加載a.com任何子域名的資源
https://img.com/ img-src https://img.com/ 允許加載img.com的https資源(協議需匹配)
https:/ img-src https:/ 允許加載https資源
'unsafe-inline'/ script-src 'unsafe-inline'/ 允許加載inline資源(例如常見的style屬性，onclick，inline js和inline css等等)
'unsafe-eval'/ script-src 'unsafe-eval'/ 允許加載動態js代碼，例如eval()
```
# 總結
CSP協議可以控制的內容非常多，而且如果不特別指定`'unsafe-inline'`時，頁面上所有inline樣式和腳本都不會執行；
不特別指定`'unsafe-eval'`，頁面上不允許使用new Function，setTimeout，eval等方式執行動態代碼。在限制了頁面資源來源之後，被XSS的風險確實減少

如果考慮影響太大，可以更改匹配規則
> Content-Security-Policy-Report-Only: script-src 'self'; report-uri http://test/

這樣，如果也面上有inline JS，依然會執行，只是瀏覽器會指定地址發送一個POST請求，包含這樣的信息
> {"csp-report":{"document-uri":"http://test/test.php","referrer":"","violated-directive":"script-src 'self'","original-policy":"script-src 'self'; report-uri http://test/","blocked-uri":""}}


# refer
https://imququ.com/post/content-security-policy-reference.html
https://www.w3.org/TR/CSP/
https://stackoverflow.com/questions/43249998/chrome-err-blocked-by-xss-auditor-details
https://coreruleset.org/20181212/core-rule-set-docker-image/