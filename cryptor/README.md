# 前言
加密技術博大精深...

寫代碼的時候常常搞不懂一些加密技術的關鍵代名詞，在這邊把一些常見的相關加密或壓縮方法條列出來

1. base64
2. md5
3. aes
4. rsa encrypt/decrypt
5. 對稱加密
6. 非對稱加密

# 為什麼要使用Base64編碼
Base64原理：將8位的二進位制位元組序列劃分為6位的塊，不足的尾部補0(以=結尾)，然後將這些6位的塊對映到一張含有64個字元的表中。

為什麼要使用Base64呢？

1、防止透傳使用者名稱和密碼
2、使用者輸入的資訊中如果包含國際字元或者Http頭無法識別的字元，則必須將要傳輸的資訊轉為Base64，因為Base64是ASCII的子集，http協議可以識別。


# refer:
為什麼要用base64，有哪些情境需求?
- https://www.zhihu.com/question/36306744

# extend-refer:
golang的AES加解密算法
- https://www.jianshu.com/p/9c1c8958b279