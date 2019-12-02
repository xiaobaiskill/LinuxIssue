# 這邊將會記錄學習k8s的筆記

# refer:
- 如何部署nsqd:
> https://github.com/xitu/gold-miner/blob/master/TODO1/kubernetes-distributed-application.md


# extend-refer:
- 在mac上部署minikube
> https://matthewpalmer.net/kubernetes-app-developer/articles/guide-install-kubernetes-mac.html


1. 安裝docker
2. 安裝VirtualBox: `brew cask install virtualbox`
3. 安裝kubectl: `brew install kubectl`
4. 安裝Minikube: 
```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.27.0/minikube-darwin-amd64 &&\
      chmod +x minikube &&\
      sudo mv minikube /usr/local/bin/
```
5. 啟動minikube: `minikube start`
(等待下載結束...)
6. 確認cluster設定完成: `kubectl api-versions`