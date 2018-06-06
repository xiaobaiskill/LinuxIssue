### 參考網址
- https://philipzheng.gitbooks.io/docker_practice/content/dockerfile/instructions.html
- https://bonze.tw/dockerfile簡單介紹/

### 名詞介紹
```
FROM : 開頭宣告要製造的image名稱，格式為 FROM <image>或FROM <image>:<tag>

MAINTAINER : 維護者信息

RUN : 放置要在container內部執行的cli，格式為 RUN <command> 或 RUN ["executable", "param1", "param2"] （備註：前者將在 shell 終端中運行命令，即 /bin/sh -c；後者則使用 exec 執行。）

CMD : 使用何種指令執行，CMD ["executable","param1","param2"] 使用 exec 執行；CMD command param1 param2 在 /bin/sh 中執行，使用在給需要互動的指令；CMD ["param1","param2"] 提供給 ENTRYPOINT 的預設參數；

COPY : 複製本地端的 <src>（為 Dockerfile 所在目錄的相對路徑）到容器中的 <dest>

ENTRYPOINT : 指定容器啟動後執行的命令，並且不會被 docker run 提供的參數覆蓋，ENTRYPOINT ["executable", "param1", "param2"]
```

### 範例
- 1.
```
FROM ubuntu:16.04
MAINTAINER jim 
RUN apt-get update && \
    apt-get -qq install python3 python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY ./requirements3.txt /requirements3.txt
RUN pip3 install -r requirements3.txt

ENTRYPOINT ["/bin/bash"]
CMD ["bash"]
```
- 2.
```
FROM codeception/codeceptjs
MAINTAINER jim_weng
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# 把該目錄位置下的檔案資料夾放入映像檔內資料夾tests位置內
# 在這邊相當於cp -r ./CodeceptJS ----> container:~/tests
ADD ./CodeceptJS /tests
ENTRYPOINT ["/codecept/docker/entrypoint"]
CMD ["bash","/codecept/docker/run.sh"]
```

### 使用Dockerfile製作一個image
- 基本的格式為 docekr build [選項] 路徑
指令：sudo docker build -t 映像檔名:映像檔標籤 .

### 使用既有映像檔執行container
> docker run 映像檔名:映像檔標籤 (視情況，可以決定是否要額外執行cmd)
```
使用範例1.Dockerfile所製作的映像檔帶起container
-> docker run image1_name:image1_tag
-> root@2178645:
會以bash模式直接進入該映像檔
```

