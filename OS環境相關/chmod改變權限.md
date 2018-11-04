# Linux常用指令chmod
# 前言
- 可以使用ls -al
Linux的檔案可以分為使用者/可執行模式：role(owner/group/others)：policy(read/write/execute)
紀錄字元為rwx為一組，代表其中一個一個role的可執行權限，排列組合共九種情況(e.g. rwxrwx---表示owner/group都可以對該檔案執行read/write/execute)
其中r:w:x分別代表分數4:2:1。(e.g. rwxrwx---表示(4+2+1)(4+2+1)(0+0+0)=770)
代表owner以及該group都有read/write/execute權限
- 改變及閱讀權限在Linux經常使用，記錄常用的權限對照表。
1. 664 : owner/group有讀寫權限，其餘使用者只能閱讀
2. 777 : 所有人皆可以讀寫即執行。
- 備註:
對應圖表
```
1: Execute only
2: Write only
3: Write and Execute
4: Read only
5: Read and Execute
6: Read and Write
7: Read, Write and Execute
```
# reference 
1. http://linux.vbird.org/linux_basic/0210filepermission.php
2. http://shian420.pixnet.net/blog/post/344938711-%5Blinux%5D-chmod-%E6%AA%94%E6%A1%88%E6%AC%8A%E9%99%90%E5%A4%A7%E7%B5%B1%E6%95%B4!