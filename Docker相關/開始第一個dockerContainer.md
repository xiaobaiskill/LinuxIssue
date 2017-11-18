#### 參考網站
https://philipzheng.gitbooks.io/docker_practice/content/image/create.html

#### 簡介
https://blog.hellosanta.com.tw/網站設計/伺服器/教你一次學會安裝-docker-開始玩轉-container%C2%A0容器世界
//名詞//相對關係
docekr : VMware
container : VM
image : OVA

#### 第一個container
docker run --name testname -it ubuntu:16.04 /bin/bash
-i  :interactive 互動
-i : tty模式(類似ubuntu的另外開啟一個tty視窗的意思)
--name : 可以給指定名稱testname(也可以不給)
ubuntu:16.04 : 從docker image 或docker hub內拉出一個ubuntu-16.04的container
/bin/bash : 進入一般的cli模式

#### 進入docker後
apt upgrade -y 
apt update -y
..
安裝所有需要的環境~
(如果有需要scp 可以下apt install openssh-client去抓其他位置的資料放進container)
...
exit
安裝完畢後就離開吧! 開始準備製作image

#### 製作image
docker commit -m "要加入的資訊" -a "指定使用者訊息" CONTAINER_ID IMAGE_NAME
(PS: docker cli都要給小寫! CONTAINER_ID以及IMAGE_NAME換成指定的名字。)
