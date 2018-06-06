# 介紹ab(ApacheBench)以及使用相關功能做壓力測試
reference : 
```
http://icodding.blogspot.com/2015/08/apachebench.html
https://dywang.csie.cyut.edu.tw/dywang/rhel7/node42.html
```

# 參數介紹
1. -k : 使用KeepAlive連線(keep-alive ref:https://en.wikipedia.org/wiki/HTTP_persistent_connection)

2. -c : 同時連線數量，模擬多個使用者設定
3. -n : 壓力測試會發出的總request數量
4. -e : 將測試結果輸出到一個CSV file
> e.g. [root@localhost~]# ab -k -e outputname.csv -c 100 -n 500 http://127.0.0.1/
`表示讓100個使用者針對localhost發送總共500個請求。`

# 報表介紹
1. Complete requests : 完成的Request次數
2. Failed requests : 失敗的Request次數
3. Requests per second : 每秒能處理的Request(越大越好)
4. Time per request : 單獨完成一個Request的時間(越短越好)
5. Connection Times :
－－Connect     client發出Request到server收到的時間
－－Processing     server收到Request到server Response的時間
－－Waiting     client發出Request到client收到Response的時間
－－Total     Connect+Processing
