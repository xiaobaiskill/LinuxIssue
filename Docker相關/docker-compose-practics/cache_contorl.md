# 常見
public: 可以被任何對象，包括發送請求的客戶端/代理伺服/CDN等緩存。
private: 只能被用戶緩存，但是不能作為共享緩存(無法被代理伺服/CDN緩存)
no-cache: 可以緩存，但是對於緩存的資源。每次都會詢問原伺服器，是否有更新資源
no-store: 完全不緩存，每次請求都回源拿取

# refer
https://medium.com/frochu/http-caching-3382037ab06f
https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/Cache-Control
https://blog.techbridge.cc/2017/06/17/cache-introduction/
https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/http-caching?hl=zh-tw