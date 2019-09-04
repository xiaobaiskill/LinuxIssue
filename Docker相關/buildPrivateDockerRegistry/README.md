# 透過docker run產生自己的docker registry

# quick start
使用`docker run`帶起一個放置`docker images`的server
> docker run -d -p 5000:5000 -v /tmp:/var/lib/registry --name registry registry:2


# refer:
- https://ithelp.ithome.com.tw/articles/10191213