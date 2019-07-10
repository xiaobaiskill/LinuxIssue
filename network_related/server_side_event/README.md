# Server-Side Event
Server-Side Event(縮寫SSE)，html5的規格

```
A server-sent event is when a web page automatically gets update from a server
This was also possible before, but the web page would have to ask if any update were available. With server-sent events, the updates come automatically.
Examples: Facebook/Twitter updates, stock price updates, news feeds, sport results, etc.
```


# 從Server端接收事件
server-sent event API包含在EventSource接口；為了與Server開啟連線並接收事件，需要創建一個標註伺服器腳本的`EventSource`物件:
```
var evtSource = new EventSource("ssedemo.php");
```
```
// 如國這個事件請求是來自其他domain要改為:
var evtSource = new EventSource("//api.example.com/ssedemo.php", { withCredentials: true } ); 
```
```
// 當建構好event source就可以開始監聽伺服器傳來的訊息:
evtSource.onmessage = function(e) {
  var newElement = document.createElement("li");
  
  newElement.innerHTML = "message: " + e.data;
  eventList.appendChild(newElement);  // 透過eventList可以監聽事件
}
```
```
// 也可以利用`addEventListener()`監聽事件
evtSource.addEventListener("ping", function(e) {
  var newElement = document.createElement("li");
  
  var obj = JSON.parse(e.data);
  newElement.innerHTML = "ping at " + obj.time;
  eventList.appendChild(newElement);
}, false);

// This code is similar, except that it will be called automatically whenever the server sends a message with the event field set to "ping"; it then parses the JSON in the data field and outputs that information.
```


# 從伺服器發送事件
伺服器端的腳本如果需要發送事件必須要使用`MIME`類別的`text/event-stream`;如此一來，每個通知都會以`block`的形式被送出來
```
e.g. PHP demo
date_default_timezone_set("America/New_York");
header("Content-Type: text/event-stream\n\n");

$counter = rand(1, 10);
while (1) {
  // Every second, sent a "ping" event.
  
  echo "event: ping\n";
  $curDate = date(DATE_ISO8601);
  echo 'data: {"time": "' . $curDate . '"}';
  echo "\n\n";
  
  // Send a simple message at random intervals.
  
  $counter--;
  
  if (!$counter) {
    echo 'data: This is a message at time ' . $curDate . "\n\n";
    $counter = rand(1, 10);
  }
  
  ob_flush();
  flush();
  sleep(1);
}

// The code above generates an event every second, with the event type "ping". Each event's data is a JSON object containing the ISO 8601 timestamp corresponding to the time at which the event was generated. At random intervals, a simple message (with no event type) is sent.
```


# 錯誤處理
當有錯發生時，可以透過`onerror`回傳錯誤給`EventSource`
```
evtSource.onerror = function(e) {
    alert("EventSource failed.");
};
```

# 關閉事件串流
預設的情況下，client與server的連線如果斷了的話，連線會自動重置。可以透過`.close()`的方法終止連線
```
evtSource.close();
```

# 事件串流(Event Stream)格式
- Fields:
1. event
2. data
3. id
4. retry


# refer
- https://developer.mozilla.org/zh-TW/docs/Web/API/Server-sent_events/Using_server-sent_events
- https://www.w3schools.com/html/html5_serversentevents.asp
- https://www.ruanyifeng.com/blog/2017/05/server-sent_events.html
- https://serverfault.com/questions/801628/for-server-sent-events-sse-what-nginx-proxy-configuration-is-appropriate