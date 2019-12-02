# 使用nginx做正向代理
通常情境是使用nginx做反向代理以期達到附載均衡，或調度部分服務。

### 爬蟲需求有時候必須使用到跳板IP來進行偽裝
使用`proxy_pass=http://$http_host$uri$is_args$args`來做中繼轉跳

### quick start and check
- http_proxy:
> http_proxy=http://${nginx_url}:80 curl http://${web_url}:81
or 
> curl http://${web_url} -x http://${proxy_url}:80

- https_proxy:
> 目前nginx沒有直接支援，需要另外編譯nginx模組才能實踐，或改用apache模組支持https正向代理
or
> curl https://${web_url} -x https://${proxy_url}:443

# refer:
- https://stackoverflow.com/questions/46060028/how-to-use-nginx-as-forward-proxy-for-any-requested-location
- https://www.itread01.com/content/1529062823.html

# curl with -x proxy
- https://stackoverflow.com/questions/9445489/performing-http-requests-with-curl-using-proxy