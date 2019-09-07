# 使用docker-compose帶起一個grafana的服務
> docker-compose up -d

# 使用mount volume的方式將硬碟掛在服務外
> grafana-storage:/var/lib/grafana

# 後記:
1. 目前grafana在告警上支援raw sql比較完整，有時候填完query後增加告警會失敗
2. 透過點選genereate raw sql來取代原本的query，在添加可以成功設立告警
3. 在mount volume的時會因為`使用者權限不符`導致grafana初始話失敗，可以透過設定`user`參數予以克服

# refer:
- https://grafana.com/docs/installation/docker
- https://github.com/grafana/grafana-docker/issues/155
- https://dev.to/acro5piano/specifying-user-and-group-in-docker-i2e