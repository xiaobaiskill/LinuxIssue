# 介紹
使用docker達到可以快速啟用一個桌面，供測試以及遠端連線使用。
Support a desktop UI for linux server

# 範本
```yml
version: '3.1'

services:
    vncserver:
        restart: always
        image: consol/centos-xfce-vnc
        ports:
            - 5901:5901
            - 6901:6901

```

# 快速啟動
打開網頁`http://localhost:6901`，並且輸入對應的密碼`vncpassword`


# refer:
- https://github.com/ConSol/docker-headless-vnc-container