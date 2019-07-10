# 哪些請求會使用 CORS？
跨來源資源共用標準可用來開啟以下跨站 HTTP 請求：

使用 XMLHttpRequest 或 Fetch API 進行跨站請求，如前所述。
網頁字體（跨網域 CSS 的 @font-face 的字體用途），所以伺服器可以佈署 TrueType 字體，並限制只讓信任的網站跨站載入。
WebGL 紋理。
以 drawImage 繪製到 Canvas 畫布上的圖形／影片之影格。
CSS 樣式表（讓 CSSOM 存取）。
指令碼（for unmuted exceptions）。

# 三種跨域名請求
1. 簡單跨域請求
2. 預檢請求
3. 身份驗證請求


# refer
- https://developer.mozilla.org/zh-TW/docs/Web/HTTP/CORS
- https://developer.mozilla.org/zh-TW/docs/Web/HTTP/Server-Side_Access_Control