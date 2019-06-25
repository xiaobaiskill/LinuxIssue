# Ajax (Asynchronous JavaScript and XML)
Ajax(非同步JavaScript及XML)，描述一種使用數個既有技術的方法
> 這些技術包括HTML、XML、層疊樣式表、JavaScript、文件物件模型、XML、XSLT以及XMLHttpRequest物件
當這些技術被結合在Ajax模型中，Web應用程式便能更快速、即時更動介面及內容，不需要重新讀取整個網頁，讓程式更快回應使用者的操作

1. XMLHttpRequest(是JavaScript Object)，後台發送HTTP請求
2. JavaScript DOM，修改HTML來展示資訊
3. HTTP請求和伺服器交互


# AJAX應用
1. 運用XHTML+CSS來表達資訊
2. 運用JavaScript操作DOM(Document Object Model)來執行動態效果
3. 運用XML和XSLT操作資料
4. 運用XMLHttpRequest或新的Fetch API與網頁服務器進行異步資料交換
> notes: AJAX與Flash、Sliverlight和Java Applet等RIA技術是有區分的


# 資料請求範例
XMLHttpRequest物件open()方法需要準備三個參數
1. http方法(post/get)
2. 處理需要的料請求頁面
3. 用布林值決定資料傳輸模式 可選，是否是異步請求。如果是true(默認值)，表示是異步請求
```
e.g.
    var xhr = new XMLHttpRequest();

    xhr.open('get',"http://104.155.197.92/cache.txt",false);
    xhr.send(null);
    console.log(xhr);
```
> notes: 這些要一起放入console，同時執行，不是分別執行...
```
- 預設回傳值
XMLHttpRequest {onreadystatechange: null, readyState: 1, timeout: 0, withCredentials: false, upload: XMLHttpRequestUpload, …}
onabort: null
onerror: null
onload: null
onloadend: null
onloadstart: null
onprogress: null
onreadystatechange: null
ontimeout: null
readyState: 4
response: "jim-test-1234123↵"
responseText: "jim-test-1234123↵"
responseType: ""
responseURL: "http://104.155.197.92/cache.txt"
responseXML: null
status: 200
statusText: "OK"
timeout: 0
upload: XMLHttpRequestUpload {onloadstart: null, onprogress: null, onabort: null, onerror: null, onload: null, …}
withCredentials: false
__proto__: XMLHttpRequest
```
> 如果只要拿其中的responseText，可以透過指定`.`來獲得單一物件
```
e.g.
    var xhr = new XMLHttpRequest();

    xhr.open('get',"http://104.155.197.92/cache.txt",false);
    xhr.send(null);
    console.log(xhr.responseText);
```
```
- 預計結果
jim-test-1234123
```


# 回傳值onlad解釋
前面的回傳值有一項為`onload`，表示該執行會等程式跑完再處理事件，自動觸發事件內容
- 流程
  1. 建立一個XMLHttpRequest
  2. 傳送請求到伺服器索取回應
  3. 當回應的資料回到瀏覽器上後
  4. 資料處理
```
e.g.
    var xhr = new XMLHttpRequest();

    xhr.open('get',"http://104.155.197.92/cache.txt",true);
    xhr.send(null);

    xhr.onload= function() {
        console.log(xhr.responseText);
    }

預計回傳結果
ƒ () {
        console.log(xhr.responseText);
    }
VM1769:7 {"jim":"jim"}
```
> 也可以針對xhr.onload的function做處理，再詳細撈資料
```
    var xhr = new XMLHttpRequest();

    xhr.open('get',"http://104.155.197.92/cache.txt",true);
    xhr.send(null);

    xhr.onload= function() {
        console.log(xhr.responseText);
    }

    console.log(xhr.responseText);
    xhr.onload= function(){
        console.log(xhr.responseText);
        var str = JSON.parse(xhr.responseText);
		console.log(str["jim"]);
    }

預計回傳結果
ƒ (){
        console.log(xhr.responseText);
        var str = JSON.parse(xhr.responseText);
		console.log(str["jim"]);
    }
VM1762:12 {"jim":"jim"}

VM1762:14 jim
```

# refer
https://ithelp.ithome.com.tw/articles/10200409
http://www.runoob.com/ajax/ajax-tutorial.html
http://huli.logdown.com/posts/2223581-ajax-and-cors
http://www.w3school.com.cn/jquery/ajax_ajax.asp