# 動機
直撥平台正夯

# 基本介紹
### 名詞解釋
1. 常用協議: RTMP(Real Time Messaging Protocol)、HLS(Http Live Streaming)、WebRTC(Web Real-Time Communication)
2. 推流: 直撥端將資料(影/音)推送到Server
3. 拉流: 觀眾端將資料(影/音)拉下到本地

#### RTMP
1. RTMP是Real Time Message Protocol(實時消息傳輸協議)，是Adobe公司為Flash/AIR平台和服務器之間音、視頻及傳輸開發的實時消息傳送協議
> RTMP基於TCP，包括RTMPT/RTMPS/RTMPE等多種變種

2. RTMP協議中，視頻必須是H264編碼，音頻必須是AAC或是MP3編碼，且多以flv格式封包。RTMP是目前最主流的流媒體傳輸協議，對CDN支持良好，實現難度也較低

3. 不過RTMP不直接支援瀏覽器，且Adobe已不再更新。因此直撥服務要執持瀏覽器的話，需要另外的推送協議支持。

#### HLS
1. Http Live Streaming是由Apple公司定義的基於HTTP的流媒體實時傳輸協議。它的原理是將整個流分為多個小的文件來下載，每次只下載若干個。
2. 服務器端會將最新的直撥數據生成新的小文件，客戶端只要不停地按順序播放從服務器獲取到的文件，就實現了直撥。
3. 基本上HLS是以點播的技術實現了直撥的體驗。因為每個小文件的時長很短，客戶端可以很快地切換碼率，以適應不同帶寬條件下的播放。
4. 分段推送的技術特點，決定了HLS的延遲一般會高於普通的流媒體直撥協議
5. 傳輸內容
   1. M3U8描述文件
   2. TS媒體文件: TS媒體文件中的視頻必須是H264編碼，音頻必須是AAC或是MP3編碼
6. 由於數據通過HTTP協議傳輸，所以完全不用考慮防火牆或者代理的問題。S

#### WebRTC
1. WebRTC(Web Real-Time Communication)，即`源自網頁即時同信`。WebRTC是一個支持瀏覽器進行實時語音、視頻對話的開源協議。
2. WebRTC的支持者甚多，Google、Mozilla、Opera推動其成為W3C推薦標準
3. WebRTC支持目前主流瀏覽器，並基於SRTP和UDP，即便在網絡信號一班的情況下也具備較好的穩定性
4. 此外，WebRTC可以實現點對點通信，通信雙方延遲低，是實現`連麥`功能比較好的選擇


### 架構
基於目前既有的協議，這邊採用rtmp來進行實做
```
直播發送地 -> 直播中間層 -> 觀眾


//// 對應元件 ////

rtmp-publisher -> rtmp-server -> rtmp-client
```


# refer:
- https://medium.com/@yenthanh/setup-a-rtmp-livestream-server-in-15-minutes-with-srs-1b0046c77267
- https://www.zhihu.com/question/26038990
- https://github.com/gwuhaolin/livego


# 後記:
一開始比較大的困擾是，要怎麼去運作並且驗證運作是正確的。
- 確認RTMP server正常
- 確認推流正常
- 如何使用OBS(最大坑...一堆文章推薦用obs當client做拉流...但是都沒有比較完整的教學文章)
- 反覆嘗試，如何快速搭建一個RTMP，了解實際的運作模式

# extend refer
使用nginx-RTMP模組當RTMP伺服器
- https://www.youtube.com/watch?v=n-83P2InwhU
- https://www.youtube.com/watch?v=1qH2bo7NHzg

使用obs教學...obs對於平常沒有在玩影音視頻的初學者真的UI/UX設計超級不友善...最後是看到這張圖檔才知道設定位置...
- file:///Users/jhenhuei/Downloads/%E9%81%94%E5%AD%B8%E5%A0%82-%E6%93%8D%E4%BD%9C%E6%89%8B%E5%86%8A(%E7%9B%B4%E6%92%AD).pdf
- http://www.eyeweb.com.tw/archives/3539


# docker-compose
- https://hub.docker.com/r/tiangolo/nginx-rtmp/



# 如何使用docker帶起一個rtmp-server
### 預先安裝相關軟體
1. docker
2. docker-compose
3. OBS : https://obsproject.com/download
4. VLC : https://www.videolan.org/vlc/download-macosx.html

### 執行步驟
1. 使用`docker-compose up -d`帶起rtmp-server做服務
2. 打開OBS: 設定 1.設定輸入源為螢幕擷取畫面 2.選擇串流位置為本機`rtmp://127.0.0.1:1935/live/`，輸入密鑰`123`
3. 打開VLC: 設定 1.接串流位置`rtmp://127.0.0.1:1935/live/123`

# 註解
2-1: 設定OBS輸入源為`擷取螢幕輸入`
![image](https://github.com/jim0409/LinuxIssue/blob/master/%E7%9B%B4%E6%92%A5%E7%9B%B8%E9%97%9C%E7%A7%91%E6%99%AE/obs%E6%96%B0%E5%A2%9E%E8%BC%B8%E5%85%A5%E6%BA%90.png)

2-2: 設定OBS輸出位置為rtmp-server `rtmp://127.0.0.1:1935/live`，夾帶密鑰`123`
![image](https://github.com/jim0409/LinuxIssue/blob/master/%E7%9B%B4%E6%92%A5%E7%9B%B8%E9%97%9C%E7%A7%91%E6%99%AE/obs%E8%A8%AD%E5%AE%9A%E4%B8%B2%E6%B5%81%E9%80%A3%E6%8E%A5%E4%BD%8D%E7%BD%AE.png)

2-3: 設定VLC接串流位置`rtmp://127.0.0.1:1935/live/123`
![image](https://github.com/jim0409/LinuxIssue/blob/master/%E7%9B%B4%E6%92%A5%E7%9B%B8%E9%97%9C%E7%A7%91%E6%99%AE/vlc%E8%A8%AD%E5%AE%9A%E6%8E%A5%E5%85%A5%E4%B8%B2%E6%B5%81.png)
