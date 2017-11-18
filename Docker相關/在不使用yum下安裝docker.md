#### 參考官方網站; (Install Docker CE from binaries | Docker Documentation)
https://docs.docker.com/engine/installation/linux/docker-ce/binaries/

#### 系統需求;
1. A 64-bit installation
2. Version 3.10 or higher of the Linux kernel. The latest version of the kernel available for you platform is recommended.
3. iptables version 1.4 or higher
4. git version 1.7 or higher
5. A ps executable, usually provided by procps or a similar package.
6. XZ Utils 4.9 or higher
7. A properly mounted cgroupfs hierarchy; a single, all-encompassing cgroup mount point is not sufficient. See Github issues #2683, #3485, #4568).


1 & 2. 64位元, 核心3.10以上linux系統  : 可以用 uname -a 查詢資訊
3. iptables -V : 查詢版本
4. git --version : 查詢版本
5. 確保ps系統能正常執行


#### 安裝流程
1. Install static binaries
Download the static binary archive. Go to https://download.docker.com/linux/static/stable/
2. tar
tar xzvf /path/to/<FILE>.tar.gz
3. 將壓縮檔出來的bin檔移到想要放的目錄下
sudo cp docker/* /usr/bin/
4. Start the Docker daemon
sudo dockerd &
(備註 : 在這邊直接跑daemon會出問題, 因為docker還沒加入group - 詳見下面備註)
5. 確認Docker是否能正常執行, 可以用hello-world確認
sudo docker run hello-world


#### 正確執行Docker daemon
需要參考官方文件 Post-installation
https://docs.docker.com/engine/installation/linux/linux-postinstall/

1. sudo groupadd docker
2. sudo usermod -aG docker $USER (這邊$USER 我是直接改root)
3. 如果docker是裝在實體機上請登出後重新登入, 如果是裝在VM上請重開機
4. 測試docker run hello-world

#### 為了正確啟動docker, 需要另外再/usr/lib/systemd/system添加service文件
文件a. docker.service
[docker.service.txt](https://github.com/jim0409/-Docker-/files/1303370/docker.service.txt)

文件b. docker.socket
[docker-socket.txt](https://github.com/jim0409/-Docker-/files/1303372/docker-socket.txt)

#### 接著執行enable確認docker有正常帶起
sudo systemctl enable docker
