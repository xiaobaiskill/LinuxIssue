### 參考網址
https://docs.influxdata.com/influxdb/v1.3/tools/shell/

### 指令
influx -host influxdb.mydomain.com -database primary -format csv -execute "select time,value from \"continuous\" where channel='ch123'" > outtest.csv

### 目的
撈取influxdb內telegraf database下measurement sai_disk_smart下的資料。

### influxDB架構簡介
influxDB為一個database software;
telegraf為influxDB下的一個database;
sai_disk_smart為一個measurements;

### 實作
e.g. 在特定機台下撈取該機台的influxDB下Database : telegraf / Measurements : sai_disk_smart的資料,並將資料存成test.csv

#### Steps
1. ssh user@ip
2. user@ip : influx -database telegraf -format csv -execute "select * from sai_disk_smart" > test.csv

