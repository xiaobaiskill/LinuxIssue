# HAR_FILE (HTTP Archive)
HAR檔案，是一個用來追蹤信息的壓縮檔，通常可以從瀏覽器中獲得
- HAR檔案最主要的目的
  1. 改善能問題：對一些有系統瓶頸或是讀取緩慢的狀況做分析
  2. 網頁渲染問題：追蹤一些網頁請求的資源讀取


# HAR_FILE_Components
為了增加資訊可讀性，HAR檔案是以JSON格式被存取下來的

- 在HAR檔案，紀錄花費時間的幾個專有名詞的解釋
  - Stalled/Blocking: 直到請求開始發送前所花費的時間，記載這個請求在哪個代理伺服器或是建立哪些連線
  - Proxy Negotiation: 在代理伺服建立連線花費的時間
  - DNS Lookup: 做DNS Lookup所花費的時間
  - Initial Connection/ Connecting: 初始化建立連線所花費的時間
  - SSL: 完成SSL握手所花費的時間
  - Request Sent/ Sending: 請求花費的時間
  - Waiting(TTFB): Time To First Bytes的意思，指得到第一個請求回應的時間
  - Content Download/ Downloading: 收到回應資料的時間

# 產生HAR檔案的方式
開啟google chrome的developer tools點選Network，在頁面中點選右鍵，下載成HAR檔案

# 分析HAR檔案要點
1. Resources not being cached: 靜態物件通常不需要每次都重新請求
2. Resources with the longest load time: 依據請求資源的不同，通常可以藉由壓縮(compressing)資源、結合(combining)資源或是移除(removing)不需要的資源來達到減少讀取時間
3. Long DNS lookup times: DNS查找的時間隨著因子的增多而有所改變，如果這個請求涵括多的位置需要查找，那他可能會影響到整體請求時間。屆時就必須要考慮移動資源


# refer
https://www.keycdn.com/support/what-is-a-har-file