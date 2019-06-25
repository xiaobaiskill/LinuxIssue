# 前言
Ajax是透過前端網頁的javascript發送請求給後端，來做前後端資料交換

> 情境，像是twitch需要即時回饋資訊到網頁上，而非靜態時。
- 要跟誰拿資料?
- 要怎麼拿資料?

# API (Application Programming Interface)
API，應用程式介面。透過定義好前端請求所攜帶的參數以及請求對象，後端開放前端請求，允許前端夾帶對應的請求，並回于恰當的資訊供前端做呈現或判斷

# Ajax & HMLHttpRequest
要在瀏覽器上面發送Request，必須應用到Ajax(以非同不的方式做請求)

```
e.g. 1. 直接做請求
    var xhr = new XMLHttpRequest();

    xhr.open('get',"http://104.155.197.92/cache.txt",false);
    xhr.send(null);
    console.log(xhr.responseText);


e.g. 2. 透過需告函式做請求
    var xhr = new XMLHttpRequest();

    xhr.open('get',"http://104.155.197.92/cache.txt",true);

    xhr.onload= function() {
        if (xhr.status >= 200 && xhr.status < 400){
            console.log(xhr.responseText);
        }
    }
    xhr.send(null);


e.g. 3. 匿名函式(callback function)
sendRequest('http://104.155.197.92/', function (response) {
    console.log(response);
});
```


# Same Origin Policy (同源政策)
因為瀏覽器是安全性考量，所以如果呼叫的API跟所屬的網站域名不同，會產生`不同源`，導致瀏覽器的Request發出去以後Response收不到。此時JavaScript就會拿到傳回錯誤
- 不同源例子
  1. domain不同
  2. http v.s. https
  3. port不相同


# CORS (Cross Origin Resource Sharing)
因為大多串接API都會發生不同源的狀況，所以會在被請求的Server端加上response header:`Access-Control-Allow-Origin`告訴瀏覽器，這個請求的回應允許非同源使用，讓瀏覽器能正常接收到回傳值

當瀏覽器收到Response之後，會先檢查`Access-Control-Allow-Origin`裡面的內容，如果裡面有包含現在這個發起Request的Origin的話，就會允許通過，讓程式順利接收到Response

> notes: 通常會設定`Access-Control-Allow-Origin: *`，方便任何一個Origin都接收，所以當瀏覽器接收到這個Response後，比對目前的Origin符合*，允許跨來源請求的回應


# Preflight Request (行前檢查請求 or 預檢請求)
瀏覽器在正式Request發送前會先送出一個OPTIONs的行前檢查請求(Preflight Request)

因為CORS請求會把Request分成兩種，一種是簡單請求(simple requests);沒有帶任何自定義Header而且又是`GET`方法
> 反之，如果有帶一些自定義Header，或者請求方法不是`GET`就不是簡單請求

透過簡單請求，可以先確認這個域名是否可以符合CORS，所以簡單請求又稱為預檢請求
```
e.g.
假設某Server提供一個API網址叫做 "https://example.com/data/16"
發送一個 GET請求，可以拿到data 16的內容
發送一個 DELETE請求，可以刪除data 16的內容

如果沒有預檢請求，使用者可以再隨便一個Domain的網頁上發送一個DELETE的Request給這個API

如果瀏覽器的CORS沒有先送預檢請求，直接送出DELETE，會導致資料直接被刪除
相反的，如果有帶預檢請求，瀏覽器會因CORS的機制，先發送預檢請求，但是因為Response被瀏覽器擋住了，所以之後的DELETE請求就沒有必要再發送了
```
> 先用一個OPTIONS的請求去確認之後的Request能不能送出，這就是Preflight Request的目的


# JSONP (JSON with Padding)
對於一些不受同源政策限制的方法，像是`<script>`這個Tag，對於常常引用CDN或是Google Analytics之類的第三方套件，這是跨來源請求除了CORS以外的另一種方法

- 假設有一段HTML
```
<script>
    var response = {
        data: 'test'
    };
</script>
<script>
    console.log(response);
</script>
```
如果把response那一段拿掉，換成一串網址
```
<script src="https://another-origin.com/api/test"></script>
<sciprt>
    console.log(response);
</script>
```
如果`httsp://another-origin.com/api/test`這個網址返回的內容就是剛剛的
``
var response = {
    data: 'test'
};
``
那使用者一樣可以拿到資料，而且這些資料還是Server端控制的，所以Server可以給browser任何的資料，但是這樣的全域變數其實不太好
```
引用callback function的概念
<script>
    receiveData({
        data: 'test'
    });
</script>
<script>
    function receiveData (response) {
        console.log(response);
    }
</script>
```
> JSONP其實就是透過上面這種形式，利用`<script>`裡面放資料，並且透過指定好的function把資料帶回去

# 總結
JSONP可以存取跨來源的資料，但JSONP的缺點就是沒辦法決定要帶哪些參數，且永遠只能附加在網址上的方式(GET)帶過去，沒辦法用POST；如果可以使用CORS，應該優先考慮CORS


# refer
http://huli.logdown.com/posts/2223581-ajax-and-cors
https://blog.darkthread.net/blog/cors-options-preflight-and-iis/
http://www.runoob.com/ajax/ajax-intro.html