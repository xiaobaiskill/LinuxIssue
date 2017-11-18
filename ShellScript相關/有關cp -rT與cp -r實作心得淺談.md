### 參考網址
https://unix.stackexchange.com/questions/94831/cp-no-target-directory-explained

### 前情提要, cp -r 可以直接複製整個folder到指定的'目錄'下
- 定義
a. 要被複製的 copyFolder_name = folder
(位置/home/ubuntu/)
b. 要存放複製 localFolder_name = folder
(位置/home/)
使用一般 cp -r 
cp -r /home/ubuntu/folder /home/folder

上cli會直接將copyFolder做複製並且放到localFolder內。
(也就是會變成 /home/folder/folder 的情況。)

### 若改成 cp -rT
根據 -T 參數解釋 :  --no-target-directory  (treat DEST as a normal file)
同樣的 cli ,會變成判斷folder名稱, 所以得到的結果為 /home/folder 。

以上, 心得淺說!
