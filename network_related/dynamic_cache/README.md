# 動態緩存
對動態頁面的緩存，如對.do/ .jsp/ .aspx/ .php/ .js(nodejs)等動態頁面緩存
> 動態頁面一般都會涉及動態計算、資料庫緩存及資料庫操作，所以每一次訪問同一個頁面，所獲得的數據可能皆有所不同，如若對數據及時性要求較高的應用，可能不太適合動態緩存
```
e.g
對一個動態頁面緩存了半個小時，用戶請求訪問該動態頁面，返回緩存中的數據
很有可能，緩存中的頁面數據即半個小時前緩存的頁面數據狀態
->動態緩存是犧牲數據的即時性換取性能的技術
```
# nginx動態緩存的原理概要
nginx的動態緩存主要通過反向代理(http的負載均衡)實現，所以基本上可以實現所有動態頁面的緩存，當然靜態頁面也能緩存
```
nginx做負載均衡反向代理，將用戶請求轉發至伺服器

nginx <---- tomcat
        |
        --- tomcat
        |
        --- tomcat
```

# nginx的default.conf配置
使用跳脫字元`\`來識別`.jsp`檔案，並且透過`proxy_cache_valid`來定義個狀態的緩存時間。

```
# levels 設置目錄層次
# key_zone 設置緩存名字和共享內存大小
# inactive 在指定時間(1天)內沒人訪問則被刪除
# max_size 最大緩存空間
proxy_cache /data/nginx/cache levels=1:2 keys_zone=cache_one:200m inactive=1d max_size=30g;


server {
    listen 80;
    server_name _;
    location /{
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forward_for;
    }

    location ~.*\.jsp$ {
        proxy_cache cache_one;                  # keys_zone後的內容對應
        proxy_cache_valid 200 304 301 302 10d;  # 哪些狀態緩存多長時間
        proxy_cache_valid any 1d;               # 其他的物件緩存時間多長
        proxy_cache_key $host$uri$is_args$args; # 通過key來hash，定義KEY的值

        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    acccess_log /data/nginx/logs/default-cache.log
}
```

# jsp範例代碼
在nginx的根目錄，新增一個index.jsp檔，測試輸出的文字、當前日期以及一張圖片
```
<%@ page language="java" import="java.util.*,java.text.SimpleDataFormat,java.text.DateFormat" pageEncoding="utf-8">
<! DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>This is test page</title>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="This is my page">
    </head>
    <body>
        This is my JSP page.<br>
        <img src='luni.png'><br>
        <%
            Data date=new Date();
            DateFormat df = new SimpleDataFormat("yyyy-MM-dd hh:mm:ss");
            out.print("Now the time is :" + df.format(date));
        %>
    </body>
</html>
```




# refer
https://kknews.cc/zh-tw/other/6nqz2p.html
https://docs.nginx.com/nginx/admin-guide/content-cache/content-caching/
https://zh.wikipedia.org/wiki/Web%E7%BC%93%E5%AD%98
https://docs.nginx.com/nginx/admin-guide/content-cache/content-caching/