# 網站SSL加密原理簡介
SSL是Secure Socket Layer(安全套接層協議)的縮寫，可以在Internet上提供秘密性傳輸


# Secure Socket Layer說明
ApplicationLayer(FTP,HTTP,SMTP,...)
--
SSL Handshake Protocol/SSL Change Cipher Spec Protocol/SSL Alert Protocol
--
SSL Record Protocol
--
TransportLayer(TCP/UDP)
--
NetworkLayer(IP)
--
DataLinkLayer
--
PhysicalLayer


# SSL Handshake

這是SSL在傳輸之前，事先用來溝通雙方(用戶端與伺服器端)所使用的 `加密演算法` 或 `密鑰交換演算法`，或是在伺服器和用戶端之間安全地 `交換密鑰` 及 `雙方的身分認證` 等相關規則，讓雙方有所遵循。在身份認證方面，


##### SSLhandshake的運作流程如下;
1. SSL-client -> SSL-Server : client hello
2. SSL-Server -> SSL-client : `Server Hello`
3. SSL-Server -> SSL-client : `Certificate`
4. SSL-Server -> SSL-client : `Server Hello Done`
5. SSL-client -> SSL-Server : client key exchange
6. SSL-client -> SSL-Server : change cipher spec
7. SSL-client -> SSL-Server : finished
8. SSL-Server -> SSL-client : `Change Cipher Spec`
9. SSL-Server -> SSL-client : `Finished`
```
1. 當SSL用戶端利用Client Hello訊息將本身支援的SSL版本、加密演算法、演算法等資訊發送給SSL伺服器
2. SSL伺服器收到Client Hello訊息並確定本次通訊採用的SSL版本和加密套件後，利用Server Hello訊息回覆給SSL用戶端
3. SSL伺服器將利用Certificate訊息將本身公鑰的數位憑證傳給SSL用戶端
4. SSL伺服器發送Server Hello Done訊息，通知SSL用戶端版本和加密套件協商結束，並開始進行密鑰交換
5. 當SSL用戶端驗證SSL伺服器的證書合法後，利用伺服器證書中之公鑰加密SSL用戶端隨機生成的PremasterSecret(這是一個用在對稱加密密鑰產生的46位元組的亂數字)，並透過ClientKeyExchange消息發送給SSL伺服器
6. 當SSL用戶端發送ChangeCipherSpec消息，通知SSL伺服器後續報文將採用協商好的密鑰和加密套件進行加密
7. SSL用戶端計算已交互的握手消息的Hash值，利用協商好的密鑰和加密演算法處理Hash值，並透過Finished消息發送給SSL伺服器。SSL伺服器利用同樣的方法計算已交互的握手消息的Hash值，並與Finished消息的解密結果比較，如果兩者相同，則證明密鑰和加密套件協商成功。
8. SSL伺服器發送ChangeCipherSpec消息，通知SSL用戶後續傳輸將採用協商好的密鑰和加密套件進行加密
9. SSL伺服器計算已交互的握手消息的Hash值
    9.1 利用協商好的密鑰和加密套件處理Hash值
    9.2 並透過Finished消息發送給SSL用戶端
    9.3 SSL用戶端利用同樣的方法計算已交互的握手消息的Hash值
    9.4 並與Finished消息的解密結果比較，如果兩者相同，且MAC值驗證成功，則證明密鑰和加密套件協商成功
    9.5 在SSL用戶端接收到SSL伺服器發送的Finished消息後，
    9.6 如果解密成功，則可以判斷SSL伺服器是數位證書的擁有者即SSL伺服器身份驗證成功。
這是因為只有擁有私鑰的SSL伺服器才能從ClientKeyExchange消息中解密得到PremasterSecret，從而間接地實現了SSL用戶端對SSL伺服器的身份驗證。
```


# SSL Change Cipher Spec
用來變更雙方傳輸加解密的演算法與訊息驗證的規格，傳輸雙方可以利用此協定進行溝通並設定本次傳輸所使用的協定


# SSL Alert
當傳送雙方發生錯誤時，用來傳遞通訊雙方所發生錯誤的訊息。訊息包含告警的嚴重級別和描述


# SSL Record Protocol
SSL Record Protocol主要提供訊息的完整性及機密性要求。
1. 機密性而言，將會利用在SSL Handshake階段所得到的Key(加密金鑰)針對往來的HTTP通訊加密;
2. 至於，完整性，SSL將使用MAC(Message Authentication Code)的方式來驗證訊息是否有被更動。
3. MAC通常使用MD5演算法來確保往來的訊息並沒有被竄改


# SSL 連線四步驟
```
1. user -> Server: ClientHello
2. Server -> user: ServerHello
3. user: (1)接收伺服器回傳的證書及公鑰等相關資訊(2)產生本地金鑰並使用伺服器公鑰加密
4. user(使用伺服器公鑰加密) <-> Server(利用私鑰解密): 資料傳輸，溝通開始
```
1. SSL Client端發出ClientHello給SSL伺服器端。告知伺服器端本身可實現的算法列表和其他一些需要的資訊
2. SSL的服務器端在接收ClientHello會回應一個ServerHello，裡面確定了這次通訊所需要的演算法，並送出伺服器本身的憑證(資訊內包含身份及公鑰)
3. SSL Client會新增一個秘密金鑰，並利用伺服器傳來的公鑰來加密
4. 伺服器使用自己的私鑰解開秘密金鑰密文，取得秘密金鑰後，即利用此秘密金鑰來相互通訊。
# 上述流程中，所謂的數位憑證，採用x509格式。其中x509架構如下
最高認證中心(Root CA) -> 多個認證中心(CAs) -> 憑證(Certificate)

```
x509憑證的主要欄位
版號：憑證格式，例如v3
序號：每個CA所建立的序號均不會相同
演算法識別碼：用來計算此憑證之數位簽章的演算法
發行者：發行此憑證的CA單位
有效期限：憑證的有效期間
主體：憑證持有人的相關資料，可能包含姓名/郵政地址/E-mail等
公鑰資料：持有人的公開鑰匙及其演算法
數位簽章：CA的數位簽章，CA將上述資料經過雜湊演算法計算過後，再經過CA的私鑰加密
```

# 補充:MD5演算法
MD5是使用`單向函數`來驗證訊息的完整性，單向Hash函數指的是給予一個鍵值(Key)，即可透過鍵值藉由Hash函數取得唯一的雜湊值(Value)，即是一個單向的one-to-one函數。如果存在兩個以上的不同鍵值可以得到相同的雜湊值，即是指Hash函數產生碰撞(Collision)。

```
單向Hash(雜湊)定義如下所述，假設：
明文為M，雜湊函數是H，雜湊值為h=H(M)

單向(One-way) Hash函數需符合下列的功能：
1. 對任意長度的明文輸入，需能產生固定長度的雜湊值輸出。
2. 對於任何的明文一定可以產生相對應的Hash值，且可利用硬體或軟體來產生
3. 需可以從明文產生Hash值，但不能由Hash值反推而得到明文，例如
h = H("Hello!! World");
假如得到Hash值E23d21341DEFA789
那麼在任何情況下都不能由E23d21341DEFA789反推而得到「Hello!! World」的明文。
4. 對於明文M1，在計算上是無法找出另一個明文M2!=M1，使得H(M1)=H(M2)
5. 若H(M1)=H(M2)，則M1=M2 iff H(M1)!=H(M2)，則M1!=M2
```

# refer:
1. https://www.netadmin.com.tw/article_content.aspx?sn=1106140008
2. https://blog.csdn.net/mrpre/article/details/77867730
