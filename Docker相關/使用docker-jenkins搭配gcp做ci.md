內文參照網頁:https://github.com/twtrubiks/docker-jenkins-django-tutorial
## 這邊主要在筆記如何在user做git pull時能trigger jenkins做build
#### 事前準備
- 搭載一台可以讓github訪問的server，在此使用google cloud platform提供的server
- 使用ubuntu 16.04 server完成安裝後在instance上安裝docker-ce
- 下載gcloud（command line for google cloud) 方便在local做ssh連接到遠端，也可以透過網頁的ssh做連接。
    - 在這邊有遇過一個坑。在網頁開console不等於在該台instance開console，務必要點選ssh而非網頁右上角的console圖。
    - 因為預設的jenkins會使用到8080 port，所以要事先打開VPC的防火牆。
- 開設一個要做webhook的github(相關github設定因人而異，在這邊不做深入探討。)

#### jenkins
- 初次安裝完畢需要進行解鎖，解鎖需要key會放置在/var/jenkins_home/secrets/initialAdminPassword
- 登入後選擇使用建議選項做安裝（備註：安裝會耗費些許時間，依照網路速度而定）
- 進入jenkins後使用外掛管理程式，選擇可用的外掛(available plugin)，下載Github Integration Plugin
- 選擇建立專案(New Item)，給訂一個專案名稱後，選擇使用Freestyle project
- 在[TAG] General 下勾選GitHub project：
    - 輸入Project url:貼上[https:github.com/.../--.git/]
- 在Source Code Management勾選Git
    - 在Repositroy URL輸入[https:github.com/.../--.git/]
    - 可以選擇要做build的branch(預設為master)
- Build Trigger勾選GitHub hook trigger for GITScm polling


#### Github
- 到github專案選擇Settings，點選Webhooks，按Add webhook。
- Payload URL填上jenkins的連結網址[https://1.2.3.4:8080/github-webhook/]
- 選擇Content type為：application/json
- 預設勾選Just the push event，以及Active。
- 如果設定無誤，按下綠色按鈕Add webhook會正常添加webhook。

#### 測試
> 在local端修改repo後進行push，確認jenkins專案是否進行build。
