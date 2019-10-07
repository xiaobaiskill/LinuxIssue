# 部署試寫
### 共用部件分析
1. apiVersion: 選擇使用的K8s API版本
2. Kind: 告訴k8s，這份yaml是在哪一種角色`Deployment/ Service/ Ingress/ Secret`
3. metadata: 放置一些描述的資訊，大多是做標籤使用
   1. name: 定義出要使用的服務名字
   2. labels: 定義出這個name下面要對應的屬性;通常`metadata要跟selector的matchLabels呼應`否則會報錯`如註解[錯誤1]`，例如`app: nginx`
4. spec: 放置大部分功能敘述，尤以`selector`最為重要


### deployment
#### spec部件分析
1. selector: 透過底下的`matchLabels`來篩選出該yaml文件的配對yaml，例如`app: nginx`
2. replicas(通常會放在deployment文件): 告訴k8s，這個deployment需要幾個pod(服務)
3. template(通常會放在deployment文件): 告訴k8s，這個deployment所生成出來的pod參照的template是哪個
   1. labels: 定義出這個生成出來的pod的template的標籤
   2. spec: 告訴上層的template這個pod的規格(*註：跟外層的spec不同)
      1. hostNetwork
      2. containers
         1. name: 宣告pod裡的container名稱
         2. image: 該container是取自於哪個映像檔
         3. imagePullPolicy: 拉取映像檔的規則
         4. ports:
            1. containerPort: container對外的port號
         5. env: 該container的內部環境變數
            1. [name:value]: 給出一個環境變數對應的值
            2. [name:valueFrom[secretKeyRef:[name:key]]]: 透過參照secret.yml內的key來拿取值


### service
1. externalTrafficploicy: 告知k8s，如果該服務要獲取對外IP，應該採用的模式，例如`externalTrafficPolicy: Cluster`
2. type: 告訴k8s這個service要參照的種類，NodePort(使用區網)/ LoadBalancer(使用外網IP)
3. selector: 告訴這個service，支援的deployment是誰，例如`app: nginx`
4. ports: 告訴k8s這個service對外的通訊方式
   1. protocol: 使用的協定，例如`TCP`
   2. port: 使用的port號，例如`80`
   3. targetPort: 目標port號，通常會跟port一樣


### ingress
1. rules: 告訴`ingress-controller`這個ingress的執行規則
   1. http: 描述規則下的http的路由設定
      1. paths:
         1. path: 指定該路由下導引到哪個位置，例如`path: /*`
         2. backend: 對於指定path下要導引到哪個backend的說明，例如
            1. `serviceName: nginx`: 要導引的service.yml的`metadata: name`名稱
            2. `servicePort: 80`: 對應服務的port號


### secret
1. type: 告訴k8s這個sercet的種類，例如`type: Queue`
2. data: 定義要放置的變數鍵與值，例如
   1. `username: YWRtaW4=`: key為username，對應參照的值為`echo -n YWRtaW4=|base64 -D`


# 註解:
### 錯誤:
1. [label錯誤]---
The Deployment "nginx-test" is invalid: spec.template.metadata.labels: Invalid value: map[string]string{"color":"green", "env":"dev", "name":"nginx"}: `selector` does not match template `labels`

2. [secret不存在錯誤]--
Warning  Failed          13s (x7 over 52s)  kubelet, gke-lottery-platform-cin-default-pool-711a3ced-jh92  Error: secrets "jimkey" not found
 


# refer:
### deployment:
- https://kubernetes.io/docs/concepts/workloads/controllers/deployment/

# service:
- https://kubernetes.io/docs/concepts/services-networking/service/

### ingress:
- https://www.kubernetes.org.cn/1885.html
- https://cloud.google.com/kubernetes-engine/docs/concepts/ingress

### secret:
- https://kubernetes.io/docs/concepts/configuration/secret/

### ingress controllers
- https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/
- https://medium.com/ibm-garage/how-to-direct-different-urls-to-different-services-in-kubernetes-646438ece73a

### 關於版本問題:
- https://segmentfault.com/a/1190000017134399
- https://cloud.google.com/kubernetes-engine/docs/concepts/ingress
- https://github.com/kubernetes/website/issues/14322
