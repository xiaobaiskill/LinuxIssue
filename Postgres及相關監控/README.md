# 公司使用的是postgres，所以架設一套container化的postgres + postgres_exporter + prometheus做監控。
## 前置安裝環境
1. docker
2. docker-compose
3. 確定port 5432(db)/ 9187(exporter)/ 9090(prometheus)沒有被佔據

## 指令
- 使用Postgres Container
> docker run --name some-postgres -e POSTGRES_PASSWORD=password -p 5432:5432 -p 9187:9187 -d postgres

- 使用Postgres Exporter
> docker run --net=container:some-postgres -e DATA_SOURCE_NAME="postgresql://postgres:password@localhost:5432/?sslmode=disable" -d wrouesnel/postgres_exporter

- 啟用監控Prometheus
> 修改prometheus.yml(路徑: /prometheus/prometheus.yml)
```yml
- job_name: 'postgresql-exporter'
    static_configs:
         - targets: ['104.155.197.92:9187']
```
> 使用docker-compose up -d 建立。
> 開啟9090 port確認prometheus是否建置成功

## refer
- postgres資料庫
> https://hub.docker.com/_/postgres/

- postgres_exporter將資料倒出
> https://github.com/wrouesnel/postgres_exporter

- prometheus監控
> https://github.com/vegasbrianc/prometheus