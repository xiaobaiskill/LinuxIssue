# 筆記一些我在查詢log時候用的DSL

# query upstream time
```sh
GET /waf-*/_search
{
 "size": 0,
 "query": {
   "bool": {
     "must_not": {
       "term": { "http_user_agent:Site24x7": "Site24x7" }
     },
     "filter": [
       ### 用來filter固定字詞
       { "term": { "sender": "wafaccess" }},
       ### 針對一些沒有enbale txt字詞是需要用keyword來filter的
       { "term": { "zone_id.keyword": "aliyunjimhaoohaoo.mlytics.ai" }},
       { "term": { "host.keyword": "uat-gcpwaf1" }},
       ### 尋找一段區間，gte表示大於某數/lte表示小於某數
       { "range": { "request_time": {"gte": "1" }}},
       { "range": { "upstream_response_time": {"lte": "300" }}},
       { "range": { "@timestamp": {
             "gte": "2019-04-23T10:00:00.00Z",
             "lte": "2019-04-29T23:59:59.999Z" }}}
     ]
   }
 },
 "aggs": {
   ### 第一個詞會以key的形式回覆
   "show_the_value_of_remote_addr": {
     # terms為固定語法，
     "terms": {
       # 裡面的field才是要要填入想要顯示的key的value
       "field": "remote_addr",
       # 顯示幾筆資料
       "size": 1000
     },"aggs": {
       "show_the_value_of_bytes_sent_under_particular_addr": {
         "terms": {
           "field": "bytes_sent",
           "size": 1000
         },"aggs": {
           "show_the_request_time": {
             "terms": {"field" : "request_time"}
           }
         }
       }
     }
   }
  }
}
```

### reference:
http://www.youmeek.com/elasticsearch-dsl/


### extend-refer:
- https://strconv.com/posts/use-elastic/
- https://olivere.github.io/elastic/
- https://www.elastic.co/guide/en/elasticsearch/reference/current/search-search.html