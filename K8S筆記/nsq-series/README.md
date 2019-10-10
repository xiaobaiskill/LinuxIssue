# nsqd 系列踩坑...
1. nsqd:
   1. 需要找到nsqlookupd，要在啟動時夾帶參數`--lookupd-tcp-address`
   2. 需要對外廣播位置`--broadcast-address`
2. nsqlookupd:
   1. 需要對外廣播位置`--broadcast-address`
3. nsqadmin:
   1. 需要找到nsqlookup，要再啟動時夾帶參數`--lookupd-http-address`

# 關於k8s內部一些定義:
1. 所有deployment都不會提供對外服務，一定要透過service定義出`selector`才能被外部發現
2. 所有service都會在被創立後隨即產生一個`dns record`對應名稱為 `${serviceName}.default.svc.cluster.loal`
   1. 備註: 此處`default`會跟隨namespace改變而改變

# refer:
- https://zhuanlan.zhihu.com/p/38407817