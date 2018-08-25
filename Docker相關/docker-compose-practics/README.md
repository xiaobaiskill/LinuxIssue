#### 範本1.使用nginx:1.13.7的image帶起html目錄下的index.html
```
version: "3"
services:
  web:
    image:  nginx:1.13.7
    ports:
      - "80:80"
    volumes:
      # put index.html in folder html would mount into conatiner
      - ./html:/usr/share/nginx/html
      # put default.conf in folder conf would moutn into ...
      - ./conf:/etc/nginx/conf.d/
```

#### 名詞定義
1. version: 定義要使用的docker-compose版本，會影響到後續使用docker-compose的語法
2. services: 在services下面列表即將使用的服務，在這邊只有定義一個服務;名字叫做'web'。
3. image: 告訴docker-compose這個服務要使用的docker image，也可以使用build參數。（需要指定Dockerfile位置）
4. ports: 等同docker run -p的開port，將container內部的port導到外部對應的port
5. volumes: 等同docker run -v做mount volume，將外部的html及conf等檔案資料夾mount進container內的對應目錄資料夾。