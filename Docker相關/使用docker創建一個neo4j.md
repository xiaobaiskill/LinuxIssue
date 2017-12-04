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
    neo4j
```

