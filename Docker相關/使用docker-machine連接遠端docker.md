docker-mahcine remote-docker-host建立流程

- Pre-requisites(在local本機端) : 
1. 先安裝好docker-machine
- https://docs.docker.com/machine/install-machine
2. 產生ssh-key並且傳送給host端以達到無密碼通行
- ssh-keygen -t rsa  : 產生key
- ssh-copy-id {username}@{host_ip} :  把已經生產好的key傳送到指定的host以利後續無密碼ssh

- Pre-requisites(在host遠端) : 
1. 安裝好docker
- https://docs.docker.com/docker-for-mac/install/
2. 為使用者增加無密碼sudoer權限
- {username}@{host_ip} $ sudo vi /etc/sudoers : 打開sudoers文件夾後為{username}增加sudoer權限
- 在最後一行增加文字  > {username} ALL=(ALL) NOPASSWD:ALL
3. 確認防火牆沒有擋住 2373 port，因為docker-client會透過該port進行連接

- 開始新增可以remote host端的docekr-machine
- docker-machine create --driver generic --generic-ip-address={ip-address} --generic-ssh-key "%localappdata%/lxss/home/{bash-username}/.ssh/id_rsa" --generic-ssh-user={remote-ssh-username} {remote-docker-host}


確定建立完畢後輸入Docker-machine env {remote-docker-host} 可以看到docker-machine的環境變數
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://172.31.86.190:2376"
export DOCKER_CERT_PATH="/Users/mac/.docker/machine/machines/remote-docker-host"
export DOCKER_MACHINE_NAME="remote-docker-host"
# Run this command to configure your shell: 
# eval $(docker-machine env remote-docker-host)
要執行遠端連線，只要執行 eval $(docker-machine env remote-docker-host) 即可

- 備註:
1. generice是driver的固定參數，不需更換!
2. {ip-address}要換成要remote host端的ip
3. “%localappdata%/lxss/home/{bash-username}/.ssh/id_rsa" 要改成自己放置key的資料夾；e.g. "/Users/mac/ .ssh/id_rsa"
4. reference : http://www.kevinkuszyk.com/2016/11/28/connect-your-docker-client-to-a-remote-docker-host/
