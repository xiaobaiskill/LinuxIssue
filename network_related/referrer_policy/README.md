# Referrer Policy介紹
載入網頁時，頁面會引入圖片、JS等資源，或者從一個頁面跳到另一個頁面，都會產生新的HTTP請求，瀏覽器一般都會給這些請求加上表示來源的Referrer字段
> Referrer在分析用戶來源時很有用，有著廣泛的使用
但URL可能包含用戶敏感信息，如果被第三方網站拿到很不安全，例如把用戶`SESSION ID`放在`URL`中傳遞，第三方拿到URL就可以看到別人登入後的頁面
> 在這之前，瀏覽器會按自己的默認規則來決定是否加上Referrer

新版Referrer Policy允許使用者針對第三方網站隱藏Referrer，可以只發送來源URL的host部分，即允許referrer為空
> 允許沈默但不允許說謊，換句話說，使用者有權不告訴對方請求從哪裡過來，但是不能用假的請求來源欺騙

# Referrer Plicy States
新的Referrer Policy規定了五種Referrer策略:
1. No Referrer: `no-referrer`，任何情況下都不發送Referrer信息
2. No Referrer When Downgrade: `no-referrer-when-downgrade`，僅當頁面發生`協議降級`(如HTTPS引入HTTP資源，從HTTPS頁面跳到HTTP等)時不發送Referrer信息
    1. (目前這個規則是大部分瀏覽器都默認的)
3. Origin Only: `origin`，發送只包含host部分的Referrer。啟用這個規則，無論是否發生協議降級，無論是否本站鏈結還是站外鏈結，都會發送referrer信息
    1. 但是只包含協議+host部分，不包含具體的路徑及參數等訊息
4. Origin When Cross-origin: `origin-when-crossorigin`，僅再發生跨訪問時發送只包含host的Referrer，同域下還是完整的
    1. 與`Origin Only`的區別是多判斷了是否`Cross-Origin`，需要注意的是協議、域名和端口一致，才會被瀏覽器認為是同域
5. Unsafe URL: `unsafe-url`，無論是否發生協議降級，紋路是否本站鏈結還是站外鏈結，通通都發送Referrer信息(最不安全的策略)


# Referrer Policy Delivery
知道了有哪些策略可以用，還需要瞭解怎麼用
- 三種使用指定Referrer Policy的方式
1. header CSP(Content Security Policy)，是一個跟頁面內容安全有關的規範，在HTTP中通過response header的`Content-Security-Policy`字段來告訴瀏覽器當前頁面要使用何種CSP策略
> 透過指定response header... Content-Security-Policy: referrer no-referrer|no-referrer-when-downgrade|origin|origin-when-crossorigin|unsafe-url; 

```
e.g.
透過 <meta> 標籤，控制全部元件的referrer
<meta name="referrer" content="no-referrer|no-referrer-when-downgrade|origin|origin-when-crossorigin|unsafe-url">
> 使用meta控制網頁全部元件的referrer，如果當content值為不合法或是為空的時候採取`no-referrer`作法

透過 <a> 標籤，控制連結的referrer
<a href="http://example.com" referrer="no-referrer|origin|unsafe-url"> xxx </a>
> 這種做法只會影響一個鏈結，並且<a>標籤可以用Referrer策略只有三種: 不傳、只傳host及都傳，另外針對單一鏈結的屬性設定會優先於<meta>的屬性設定

note:
最保險的去掉referrer作法，推薦針對每一個單一屬性去做`no-referrer`設定
<a href="http://example.com" referrer="no-referrer">xxx</a>
```

# refer
https://imququ.com/post/referrer-policy.html
https://zhidao.baidu.com/question/204495077642103125.html
https://yutuo.net/archives/f1b375231265f7fd.html
https://www.chedong.com/blog/archives/001501.html

# extension
- Content-Security-Policy
https://imququ.com/post/content-security-policy-reference.html