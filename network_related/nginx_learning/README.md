# 前言
關於nginx做反向代理的介紹已經很多了，這邊將會透過自問自答的方式，記錄幾個我在工作上會用到的nginx設定以及相關技能


# nginx conf介紹
nginx有兩個主要的config
> 可以透過nginx -t來查詢設定檔路徑位置
1. nginx.conf
   1. 宣告nginx服務啟動時宣告work的數量
   2. 相關pid以及打印log的格式宣告
   3. 告訴nginx額外參考的設定檔
```
http {
    # server一定在http裡面
    server {
        # location一定在server裡面
        location {}
    }

    # 註：有時候會用include把server或是location寫在另一個config
    #    e.g. include /etc/nginx/conf.d/*.conf;
}
```
2. default.conf
   1. 定義代理靜態檔位置
   2. 定義ssl相關憑證
   3. 定義listen port
   4. 定義hostname做SNI
   5. 定義L4或L7轉發
   6. 定義自訂header(*這部分跟Header行為很有關聯) 
```
承上，deafult.conf是放在nginx/conf.d下面的一隻預設定檔
# listen 會放在server裡面，告訴nginx要監聽哪一個port
# e.g.
server {
    listen 80;
    location { ... }
}

```


# 如何用nginx轉發(Proxy Server)
nginx作為反向代理伺服器，主要可以轉發L4與L7，以下為了方便，把server放在nginx.conf裡。否則一般來說是可以放在default.conf的
- L7轉發(http應用層轉發)
如果server app是透過某個port做為介面，例如express.js，這時可以用nginx來做proxy server
```
e.g. app使用的port為2368，要讓當連到www.example.com時，交由這個app來處理。西修改/etc/hosts，讓www.example.com指向localhost

#1. /etc/hosts
127.0.0.1 www.example.com

#2. 再到nginx.conf把www.example.com指到2368這個port
server {
    server_name www.example.com;
    location / {
        proxy_pass 127.0.0.1:2368;
    }
}
```

- L4轉發(tcp傳輸層轉發)
設定load balancer，使用upstream這個directive，假設2個ip:192.168.1.1及192.168.1.2的2368 port都有相同的app
```
# 仿造上述的情境，到nginx.conf設定
http {
    upstream my_upstream {
        serverr 192.168.1.1:2368;
        serverr 192.168.1.2:2368;
    }
    server_name www.example.com;
    location / {
        proxy_pass http://my_upstream; # 指到設定的upstreadm及protocol
    }
}

```


# 如何幫nginx上憑證
憑證的來源有很多種，包括自行簽證openssl或是透過第三方let's encrypt之類的平台申請或購買。這邊不進行探討，只針對拿到憑證後應該如何幫nginx配置憑證

- nginx憑證設定
```
server {
    # 告訴nginx使用憑證時要透過哪個端口做訪問
    listen 443 ssl;
    # 告訴nginx憑證的cert資料放在哪一個資料夾下面
    ssl_certificate /etc/nginx/ssl/nginx_test.cert
    ssl_certificate_key /etc/nginx/ssl/nginx_test.key
}
```
> 備註：通常cert是代表certificate+chain或是統稱fullchain
曾遇過一個坑，在第三方平台驗證。但是因為我只放certificate沒有放chain所以平台無法識別，SSL就握手失敗了，要改成fullchain

# nginx增加http header
通常會使用到nginx的proxy_set_header有兩種情境
1. 增加cache
2. 改變原有的http轉發規則
- 情境(ㄧ)
以增加cache的機制來說，比較常見的有;private/public/no-cache/no-control，可以透過add_header Header_name Header_value
```
e.g. 我想要一個我的物件永遠不要被任何人緩存(CDN/browser)
serverr {
    listen 80;
    server_name www.example.com;
    
    location / {
        add_header Cache-Control no-stroe; # note: no-cache還是會被browser緩存   
    }
}
```
- 情境(二)
透過upgrade這個proxy_set_header設定，來達到Socket.io的轉發
```
server {
    listen 80;
    server_name www.example.com;

    location ~* \.io {      # 這邊'\'是用來做跳脫字元，識別'.'
        proxy_pass http://127.0.0.1:2368;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $http_host;
        proxy_set_header X-NginX-Proxy true;
        proxy_redirect off;
    }

    location / {
        proxy_pass http://127.0.0.1:2386;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
    }
}
```

# 反向代理IP轉發
通常為了保護源站，web server會放在proxy server(nginx)後面，這樣就不能獲取客戶的ip位址，通過$remote_addr拿到的地址通常是proxy server的ip位址，所以無法拿到正確的client ip。proxy server再轉發http請求的header中，可以增加`X-Forwarded-For`的訊息，用來記錄訪問的client端的ip給web server

```
e.g. 承上設定
server {
    listen 80;
    server_name www.example.com;

    location ~* \.io {      # 這邊'\'是用來做跳脫字元，識別'.'
        proxy_pass http://127.0.0.1:2368;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $http_host;
        proxy_set_header X-NginX-Proxy true;

        proxy_set _header X-Real-IP $remote_addr; # 加入X-Real-IP Header
        proxy_set_header X-Forward-For $proxy_add_x_forwarded_for; # 加入X-Forwarded-For Header
        
        proxy_redirect off;
    }

    location / {
        proxy_pass http://127.0.0.1:2386;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;

        proxy_set _header X-Real-IP $remote_addr; # 加入X-Real-IP Header
        proxy_set_header X-Forward-For $proxy_add_x_forwarded_for; # 加入X-Forwarded-For Header
    }
}
```

# log_format更改
nginx日誌主要有兩條指令：
- log_format: 用來設置日誌格式
- access_log: 用來指定日誌文件的存放路徑、格式(把定義的log_format寫在後面)和緩存大小;(如果不想啟用則access_log off)
```
log_format 日誌格式
1. syntax
log_format name(格式名字) template(格式樣式：想要得到什麼樣的日誌內容)
e.g.
http {
    include /etc/nginx/mine.types;
    default_type application/octet-stream;

    log_format main
    '$remote_addr - $remote_user [$time_local] "request" '
    '$status $body_bytes_s ent "http_referer"'
    '"$http_user_agent" "$http_x_forward_for"'

     log_format combinedtime '$remote_addr - $remote_user [$time_local] ' '"$request" $status $body_bytes_sent ' '"----this is referer---$http_referer" "$http_user_agent"' ' elapsed=${request_time}s';

    access_log  /var/log/nginx/access.log  combinedtime;

}

```
參數                       |  說明  |  示例
--------------------------|:-------------:|-----
$remote_addr              |  客戶端地址 | 211.28.65.253
$remote_user              |  客戶端用戶名稱 | --
$time_local               |  訪問時間和時區 | 31/May/2019/17:00:01 +0800
$time_iso8601             |  ISO8601標準格式下的本地時間 |
$request                  |  請求的URI和HTTP協議 | "GET /luni.png HTTP/ 1.1"
$http_host                |  請求地址，即為瀏覽器中輸入的地址(IP域名) | www.example.com
$status                   |  HTTP請求狀態 | 200
$upstream_status          |  upstream狀態 | 200
$body_bytes_sent          |  發送給客戶端文件內容大小 | 1547
$http_referer             |  url跳轉來源 | http://www.example.com
$http_user_agent          |  用戶端瀏覽器等信息 | "Mozilla/4.0 (compatible; MSIE 8.0: Windows NT 5.1; Trident/4.0; SV1; GTB7.0; .NET4.0C;)
$ssl_protocol             |  SSL協議版本 | TLSv1
$ssl_cipher               |  交換數據中的算法 | RC4-SHA
$upstream_addr            |  後台upstream的地址，即真正提供服務的主機地址 | 10.10.10.100:80
$request_time             |  整個請求的總時間 | 0.205
$upstream_responnse_time  |  請求過程中，upstream回應時間 | 0.002
$connection_requests      |  當前連接發生請求數
$connetion                |  所用連接序號
$msec                     |  日誌寫入時間。單位為秒，精度是毫秒
$pipe                     |  如果請求是通過HTTP流水線(pipelined)發送，pipe值為`p`否則為`.`

# access_log
用log_format設置了日治格式後，需要用access_log指定日誌文件的存放路徑；
1. syntax
   1. access_log path(存放路徑) format(自定義日誌名稱)
   > access_log logs/access.log main;
2. 設置緩存大小寫入硬碟機制
   1. buffer滿32k才寫入硬碟；假如不滿，也可以在5s後寫入硬碟
   > access_log /data/logs/nginx-access.log buffer=32k flus=5s

notes: 一般log_format在全局設定，可以設置多個。access_log可以在全局設定，但是也可以定義在server內的location中。
> e.g. 
```

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                   '"$status" $body_bytes_sent "$http_referer" '
                   '"$http_user_agent" "$http_x_forwarded_for" '
                   '"$gzip_ratio" $request_time $bytes_sent $request_length';
    log_format srcache_log '$remote_addr - $remote_user [$time_local] "$request" '
                        '"$status" $body_bytes_sent $request_time $bytes_sent $request_length '
                        '[$upstream_response_time] [$srcache_fetch_status] [$srcache_store_status] [$srcache_expire]';
    open_log_file_cache max=1000 inactive=60s;
    server {
        server_name ~^(www\.)?(.+)$;
        access_log logs/$2-access.log main;
        error_log logs/$2-error.log;
        location /srcache {
            access_log logs/access-srcache.log srcache_log;
        }
    }
}
```

# error_log
配置錯誤log的log_format以及語法同上，值得注意的是open_log_file_cache
> 對於每一條日誌記錄，都是先將文件打開，再寫入日誌，隨後關閉。可以透過open_log_file_cache來設置日誌文件緩存(default off)
```
syntax:
open_log_file_cache max=N [inactive=time] [min_uses=N] [valid=time]
```
notes:
1. max: 設置緩存豬的最大文件描述符數量，如果緩存被佔滿，採用LRU算法將描述符關閉
2. inactive: 設置存活時間，默認是10s
3. min_uses: 設置在inactive時間段內，日誌文件最少使用多少次後，該日誌文件描述符計入緩存中，默認是1次
4. valid: 設置幾察頻率，默認是60s
```
open_log_file_cache max=1000 inactive=20s valid=1m min_uses=2;
```

# 日誌分析
可以使用常見的linux指令對日誌進行分析；
1. 查找訪問頻率最高的URL和次數
   > cat access.log| awk -F '^A' '{print $10}'| sort| uniq -C
2. 查找當前日誌文件500錯誤的訪問
   > cat access.log| awk -F '^A' '{if($5 == 500) print $0}'
3. 查找當前日誌文件500錯誤的數量
   > cat access.log| awk -F '^A' '{if($5 == 500) print $0}'| wc -l
4. 查找某一分鐘內500錯誤訪問的數量
   > cat access.log| awk -F '^A' '{if($5 == 500) print $0}'| grep '09:00' |wc -l
5. 查找耗時超過1s的慢請求
   > tail -f access.log| awk -F '^A' '{if($6>1) print $0}'
6. 觀察特定欄位
   > tail -f access.log| awk -F '^A' '{if($6>1)} print $3 "|" $4'
7. 查找502錯誤最多的URL
   > cat access.log| awk -F '^A' '{if($5==502) print $1|}'| sort| uniq -c
8. 查找200空白頁
   > cat access.log | awk -F '^A' '{if($5==200 && $8 < 100) print $3 "|" $4 "|" $11 "|" $6}'

# rewrite
Nginx可以透過rewrite這個功能改寫日誌的錯誤等級

1. 開啟rewrite日誌
設置nginx.conf配置文件中的錯誤日誌級別為notice(nginx中最低級別的錯誤)，並開啟rewrite日誌
```
error_log /data/log/nginx/error.log notice;

rewrite_log on;
```
2. 配置rewrite
```
location / {
    rewrite ^/ http://example.com;
}
```
3. 重新啟動nginx
> nginx -s reload


# refer
- nginx代理設定
    - https://blog.hellojcc.tw/2015/12/07/nginx-beginner-tutorial/
    - https://blog.hellojcc.tw/2018/05/02/setup-https-with-letsencrypt-on-nginx/
    - https://sharefunyeh.gitbooks.io/webdev/content/articles/understand-nginx-proxy-load-balancing-buffer-and-cache.html
    - http://single9.net/2018/03/nginx-reverse-proxy-server-and-socket-io/


- nginx access log設定
https://lanjingling.github.io/2016/03/14/nginx-access-log/

# extend-refer
- 使用openssl自簽憑證
https://www.bear2little.net/wordpress/?p=401