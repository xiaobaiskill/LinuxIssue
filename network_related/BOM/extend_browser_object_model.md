# BOM是什麼
BOM是瀏覽器對象模型的簡寫，是指由Web瀏覽器暴露的所有對象組成的表示模型
BOM與DOM不同，沒有標準的實現，也沒有嚴格的定義，所以瀏覽器可以自由的實現BOM

BOM層次結構的頂層是窗口對象，它包含有關顯示文檔的窗口的信息。某些窗口對象本身就是描述文檔和相關信息的對象

# BOM簡介
1. BOM提供了獨立於內容而與瀏覽器窗口進行交互的對象
2. 由於BOM主要用於管理窗口與窗口之間的通訊，因此其核心對象是window
3. BOM由一系列相關的對象構成，並且每個對象都提供了很多方法與屬性
4. BOM缺乏標準，JavaScript語法的標準化組織是ECMA，DOM的標準化組織是W3C
5. BOM最初是Netscape瀏覽器標準的一部分

# 能利用BOM做什麼
BOM提供了一些訪問窗口對象的一些方法，可以用它來移動窗口位置，改變窗口大小，打開新窗口和關閉窗口
BOM最主要的功能是提供一個訪問HTML頁面的入口，document對象供使用者通過這個入口使用DOM

window對象是BOM的頂層(核心)對象，所有對象都是通過它延伸出來的，也可以稱為window的子對象

由於window是頂層對象，因此調用它的子對象時可以不顯示的指明window對象
```
e.g.
    document.write("BOM");
    window.document.write("BOM");
```

window -- window對象是BOM中所有對象的核心。window對象表示整個瀏覽器窗口，但不必表示其中包含的內容
此外，window還可以用於移動或調整它表示的瀏覽器大小


# JavaScript中的任何一個全局函數或變量都是window的屬性
window子對象
- document對象
- frames對象
- history對象
- location對象
- navigator對象
- screen對象

window對象關係屬性
- parent: 如果當前窗口為frame，指向包含該frame的窗口的frame。(frame)
- self: 指向當前的window對象，與window同意。(window 對象)
- top: 如果當前窗口為frame，指向包含該frame的top-level的window對象
- window: 指向當前的window對象，與self同意
- opener: 當窗口是用javascript打開時，指向打開它的那人窗口(開啟者)

window對象定位屬性
- IE 提供了window.screenLeft和window.screenTop對象來判斷窗口的位置，但未提供任何判斷窗口大小的方法
  - 用document.body.offsetWidth和document.body.offsetHeight屬性可以獲取視口的大小(顯示HTML頁的區域)，但它們不是標準屬性
- Mozilla提供window.screenX和window.screenY屬性判斷窗口的位置
  - 它還提供了window.innerWidth和window.innerHeight屬性來判斷視口的大小
  - window.outerWidth和window.outerHeight屬性判斷瀏覽器窗口自身的大小


# window控制的對象&方法
- Browser窗體控制: 瀏覽器視窗的大小，位置以及等待時長
- History對象: 瀏覽器的歷史紀錄
- Location對象: 設置或返回/ host/ hostname/ href/ pathname/ port/ protocol/ search
- Navigator對象: Navigator對象的屬性

# 框架與多窗口通信
- 子窗口與父窗口
  - 只有自身和使用window.open方法打開的窗口才能被JavaScript控制
- 框架
  - 在框架集或包含iframe標籤的頁面中，frames集合包含了對有框架中窗口的引用

# refer
https://blog.csdn.net/sinat_34093604/article/details/52578489
https://ithelp.ithome.com.tw/articles/10191666
https://read01.com/zh-tw/x8D63.html#.XRIgaZMzaOR
https://blog.csdn.net/fengyao1995/article/details/45790837
https://ithelp.ithome.com.tw/articles/10191666