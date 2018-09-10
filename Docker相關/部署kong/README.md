# 使用docker部署kong api-gateway
1. 安裝postgres
```shell
docker run -d --name kong-database \
                -p 5432:5432 \
                -e "POSTGRES_USER=kong" \
                -e "POSTGRES_DB=kong" \
                postgres
```

2. 把kong所需要的資料migrate到postgres
```shell
docker run --rm \
    --link kong-database:kong-database \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_HOST=kong-database" \
    -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
    kong kong migrations up
```

3. 啟動kong
```shell
docker run -d --name kong \
--link kong-database:kong-database \
-e "KONG_DATABASE=postgres" \
-e "KONG_PG_HOST=kong-database" \
-e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
-e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
-e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
-e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
-e "KONG_ADMIN_LISTEN=0.0.0.0:8001" \
-e "KONG_ADMIN_LISTEN_SSL=0.0.0.0:8444" \
-p 8000:8000 \
-p 8443:8443 \
-p 8001:8001 \
-p 8444:8444 \
kong
```
# 為kong增加api-service
1. 檢查kong是否已經正常執行，順便確認目前現有的api
```shell
curl -i localhost:8001/apis
```
2. 替kong增加一個rest api
> 在此假設curl -i http://104.155.197.92:899/dbpractice/ 是會回應對應response的
```shell
curl -i -X POST \
  --url  http://localhost:8001/apis/ \
  --data 'name=django-api' \
  --data 'uris=/dbpractice' \
  --data 'strip_uri=false' \
  --data 'upstream_url=http://104.155.197.92:8999'
```
- url : 在kong上註冊api需要使用8001 port，並且給end point 'apis'
- name : 定義在kong上註冊的api名稱，不會影響呼叫api的功能。用來作為讓kong識別檢查既有或是刪除用
- uris : 定義upstream_url後可以使用的end point
- strip_uri : 選擇false，表示後面的end point都可以被呼叫。例如/dbpractice/dbpost, /dbpractice/dbdrop
- upstream_url : 定義kong要轉接的api來源url; 表示curl -i http://104.155.197.92:8999/dbpractice/ ...是有回傳值得！

3. 呼叫一個已經在kong上被註冊過的api
```shell
curl -i localhost:8000/dbpractice/dbpost
```
- 在此處，kong預設8000 port作為代理port。

4. 刪除kong上的一個rese api
```shell
curl -i localhost:8001/api/django-api
```

# refer
1. https://docs.konghq.com/
2. https://docs.konghq.com/0.14.x/proxy/
3. https://www.cnblogs.com/zhoujie/p/kong2.html