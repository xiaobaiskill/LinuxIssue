### 安裝docker請參照官網
https://docs.docker.com/engine/installation/

### 安裝neo4j請參考網址
1. 官方提供網站
https://hub.docker.com/_/neo4j/
2. 詳細進階設定
http://neo4j.com/docs/operations-manual/current/installation/docker/

### command line : 目前預設是安裝3.0版
```
docker run \
    --publish=7474:7474 --publish=7687:7687 \
    --volume=$HOME/neo4j/data:/data \
    neo4j:3.0
```

### 後記
遇過錯誤log
```
docker run     --publish=7474:7474 --publish=7687:7687     --volume=$HOME/neo4j/data:/data     neo4j
Active database: graph.db
Directories in use:
  home:         /var/lib/neo4j
  config:       /var/lib/neo4j/conf
  logs:         /var/lib/neo4j/logs
  plugins:      /var/lib/neo4j/plugins
  import:       /var/lib/neo4j/import
  data:         /var/lib/neo4j/data
  certificates: /var/lib/neo4j/certificates
  run:          /var/lib/neo4j/run
Starting Neo4j.
2017-12-17 06:53:10.267+0000 WARN  Unknown config option: causal_clustering.discovery_listen_address
2017-12-17 06:53:10.278+0000 WARN  Unknown config option: causal_clustering.raft_advertised_address
2017-12-17 06:53:10.279+0000 WARN  Unknown config option: causal_clustering.raft_listen_address
2017-12-17 06:53:10.280+0000 WARN  Unknown config option: ha.host.coordination
2017-12-17 06:53:10.282+0000 WARN  Unknown config option: causal_clustering.transaction_advertised_address
2017-12-17 06:53:10.283+0000 WARN  Unknown config option: causal_clustering.discovery_advertised_address
2017-12-17 06:53:10.284+0000 WARN  Unknown config option: ha.host.data
2017-12-17 06:53:10.286+0000 WARN  Unknown config option: causal_clustering.transaction_listen_address
2017-12-17 06:53:10.328+0000 INFO  ======== Neo4j 3.3.0 ========
2017-12-17 06:53:10.435+0000 INFO  Starting...
2017-12-17 06:53:13.289+0000 INFO  Bolt enabled on 0.0.0.0:7687.
2017-12-17 06:53:13.837+0000 ERROR Neo4j cannot be started because the database files require upgrading and upgrades are disabled in the configuration. Please set 'dbms.allow_upgrade' to 'true' in your configuration file and try again.
2017-12-17 06:53:13.844+0000 INFO  Neo4j Server shutdown initiated by request
```
- 文獻參照
> https://github.com/mirkonasato/graphipedia/issues/8
造成原因是因為目前目前neo4j的映像檔案沒有該版本的支援。
