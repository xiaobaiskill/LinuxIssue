# filebeat介紹
filebeat是elk日誌系統中常見的一套拋轉log常用的工具


# install on centos7
1. 增加管理套件yum的搜尋key
> sudo rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch

2. 增加管理套件yum的搜尋位置，移動到`/etc/yum.repos.d`後，在該資料夾下增加一個檔案叫做filebeat.repo，並且寫入內容
```
[elastic-7.x]
name=Elastic repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
```

3. 執行安裝
> sudo yum install filebeat

4. 透過systemctl status filebeat確認安裝是否成功
> systemctl status filebeat
```log
● filebeat.service - Filebeat sends log files to Logstash or directly to Elasticsearch.
   Loaded: loaded (/usr/lib/systemd/system/filebeat.service; disabled; vendor preset: disabled)
   Active: active (running) since Sun 2019-11-17 13:59:01 CST; 42min ago
     Docs: https://www.elastic.co/products/beats/filebeat
 Main PID: 27700 (filebeat)
    Tasks: 8
   Memory: 7.1M
   CGroup: /system.slice/filebeat.service
           └─27700 /usr/share/filebeat/bin/filebeat -e -c /etc/filebeat/filebeat.yml -path.home /usr/share/filebeat -path.config /etc/filebeat -path.data /var/lib/filebeat -path.logs /var/log/filebeat

Nov 17 14:37:01 plat-dev-set filebeat[27700]: 2019-11-17T14:37:01.990+0800        INFO        [monitoring]        log/log.go:145        Non-zero metrics in the last 30s        {"monitoring": {"metrics": {"beat":{"cpu":{"system":{"ticks":180},"total":{"ticks":380,"time":{"ms":2},"value":380},"user":{"ticks":200,"...
Nov 17 14:37:31 plat-dev-set filebeat[27700]: 2019-11-17T14:37:31.986+0800        INFO        [monitoring]        log/log.go:145        Non-zero metrics in the last 30s        {"monitoring": {"metrics": {"beat":{"cpu":{"system":{"ticks":180,"time":{"ms":3}},"total":{"ticks":380,"time":{"ms":3},"value":380},"user
```

5. 將filebeat加入到開機後自動執行的daemon下
> sudo chkconfig --add filebeat

# 設定filebeat拋轉nginx的日誌
設定filebeat拋轉nginx上的access.log到logstash上
```yml
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /var/log/nginx/access.log
  fields:
    type: nginx_access
filebeat.config.modules:
  path: ${path.config}/modules.d/*.yml
  reload.enabled: false
setup.template.settings:
  index.number_of_shards: 3
output.logstash:
  hosts: ["172.18.8.201:5044"]
processors:
  - add_host_metadata: ~
  - add_cloud_metadata: ~
```


# refer
how to install
- https://www.elastic.co/guide/en/beats/filebeat/current/setup-repositories.html
設定filebeat拋轉指定的日誌檔
- https://www.itread01.com/content/1544109306.html
將nginx的access.log拋轉到logstash上
- https://www.itread01.com/content/1544117936.html
在filebeat中使用grok
- https://discuss.elastic.co/t/logstash-with-grok-patterns-applied-on-logs-coming-out-of-docker-containers/181683
使用貪懶的方式，拿取所有的message(適合快速啟用filebeat->logstash)
- https://hackmd.io/@QCZ_Kvv1ScixyAPzRYDKWQ/SytK_Y9HE?type=view
```conf
input {
  beats {
    port => 5044
  }
}

filter {
  grok {
    match => {
      "message" => "%{GREEDYDATA:result}"
    }
  }
  json {
    source => "result"
  }
  mutate {
    remove_tag => ["_jsonparsefailure"]
  }
}

output {
  elasticsearch {
    hosts => "elasticsearch:9200"
    index => "%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}"
  }
}
```

# extend-refer
example of docker-compose
- https://www.cnblogs.com/weschen/p/11046906.html


# docker elk-filebeat
- https://github.com/ChenWes/docker-elk/blob/master/filebeat/filebeat.yml

# 關於grok
- https://blog.johnwu.cc/article/elk-logstash-grok-filter.html
- https://www.elastic.co/guide/en/logstash/current/plugins-filters-grok.html

# 撰寫自己的filebeat
- https://www.itread01.com/content/1544109306.html

# filebeat to nsq
- https://github.com/chennqqi/filebeat.nsq.output