# 部署試寫
### deployment
#### 部件分析
1. metadata:
   1. name: 定義出要使用的服務名字
   2. labels: 定義出這個name下面要對應的屬性;通常`metadata要跟selector的matchLabels呼應`否則會報錯`如註解[錯誤1]`
   3. 

### service


`externalTrafficploicy`


# 註解:
### 錯誤:
1. [label錯誤]---
The Deployment "nginx-test" is invalid: spec.template.metadata.labels: Invalid value: map[string]string{"color":"green", "env":"dev", "name":"nginx"}: `selector` does not match template `labels`

2. [secret不存在錯誤]--
Warning  Failed          13s (x7 over 52s)  kubelet, gke-lottery-platform-cin-default-pool-711a3ced-jh92  Error: secrets "jimkey" not found

3. 



### 關於版本問題
- https://segmentfault.com/a/1190000017134399