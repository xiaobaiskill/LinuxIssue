## 參考網址
http://www.arthurtoday.com/2010/09/ubuntu-add-apt-repository.html

### 先解決無法使用add-apt-repository的問題!(詳見參考網址)
sudo apt-get install python-software-properties
sudo apt-get install software-properties-common

### 依照流程, 先加入repository再進行安裝!
add-apt-repository ppa:webupd8team/java
apt-get update -y
apt-get install oracle-java8-installer
