### 參考網址
http://linuxcommando.blogspot.tw/2008/10/how-to-disable-ssh-host-key-checking.html

### 可能導致原因
*在SSH到其他機台時習慣性的選擇yes記錄下該機台的資訊到known_hosts
1. OpenSSH重新安裝
2. 該host IP移轉

### 解法
利用UserKnownHostsFile=/dev/null騙過機台, 讓機台認為該server還沒有加入至known_hosts, 再透過StrictHostKeyChecking=no自動去回覆不紀錄資訊到known_host

### 加入-o UserKnownHostsFile=/dev/null
指定UserKnownHostsFile為空, 讓ssh等功能會自動去提問是否加入到known_hosts資訊。

### 加入-o StrictHostKeyChecking=no
表示自動回覆資訊, 不加入到known_hosts。

### 範例如下;
$ ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no peter@192.168.0.100
