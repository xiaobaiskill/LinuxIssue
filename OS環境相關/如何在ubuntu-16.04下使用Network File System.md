## 參考網址
https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-16-04

### 定義
a. host : host_ip (要被當作備份network file system disk用)
b. client : client_ip (可以創建一個folder以便mount host下分享出來的directory)

### host端要做的事(出租硬碟端)
1. 更新
- sudo apt-get update
2. 下載nfs-kernel-server
- sudo apt-get install nfs-kernel-server
3. 建立一個要share出來的資料夾(到時候要被mount), 並加入NFS使用root權限。
- sudo mkdir -p /home/ubuntu/shareFolder
- sudo chown nobody:nogroup /home/ubuntu/shareFolder
4. 設定NFS Exports
- vi /etc/exports
於文章底部增加兩行字; ( 詳細參數設定請見"[參考網址](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-16-04)"內容)
/home/ubuntu/shareFolder    client_ip(rw,sync,no_subtree_check)
/home       client_ip(rw,sync,no_root_squash,no_subtree_check)
5. 重啟nfs-kernel-server
- systemctl restart nfs-kernel-server
6. 調整防火牆(這邊因為ubuntu預設是關閉, 有需要設定可參閱"[參考網址](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-16-04)"連結內容)
### client端要做的事(付錢買硬碟容量的老大)
1. 更新
- sudo apt-get update
2. 下載nfs-common
- sudo apt-get install nfs-common
3. 製作一個可以連結的資料夾(mount會用到)
- sudo mkdir -p /home/ubuntu/linkFolder


### 開始mount
1. 移動到client端
- client $ :

2. mount 上host的shareFolder
- sudo mount host_ip:/home/ubuntu/shareFolder /home/ubuntu/linkFolder

3. 檢查兩邊的資料夾是否同步!
- client $ : df -h | grep host_ip

於此同時應該會看到有多mount一個資料夾!



### 備註
解除mount
1. 因為沒有設定fstab 所以重啟之後mount就會消失
2. 手動解除mount
- client $ : sudo umount /home/ubuntu/shareFolder

