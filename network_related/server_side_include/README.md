# 什麼是SSI
Server Side Include，通常稱為伺服器嵌入。是一種類似ASP的基於伺服器的網頁製作技術。大多數(尤其是基於Unix平台)的Web Server如Netscape Enterprise Server等均支援SSI命令

# 為什麼要用SSI
當靜態網頁需要支援一個小塊實時變化內容時。例如使用者登入畫面，在使用者登入後，除了登入資訊是動態的。其他大多都是可以被緩存的。此時會把使用者資訊以SSI解決"緩存部分頁面的問題"

# nginx ssi config
nginx自帶SSI，不用額外再加裝套件，支援三個配置屬性：
- ssi: 開始ssi支援，預設是off
- ssi_silent_errors: 預設是off，開啟後在處理ssi檔案時不會輸出到error.log
- ssi_types: 預設是ssi_types text/html
均可以放在http, server和location作用域下

# 範例SSI
在ssi on的配置下執行，
> docker-compose up -d
開啟index.html，會顯示a.html以及b.html的頁面。反之則會看到空白頁面


# refer
- https://codertw.com/%E5%89%8D%E7%AB%AF%E9%96%8B%E7%99%BC/46086/
- https://www.itread01.com/article/1428022145.html
- https://www.itread01.com/p/209116.html
- https://www.csie.ntu.edu.tw/~b91053/web/exp5/%A4%B0%BB%F2%ACOSSI.htm
- http://www.freewebmasterhelp.com/tutorials/ssi
- https://www.cnblogs.com/iforever/p/4417428.html