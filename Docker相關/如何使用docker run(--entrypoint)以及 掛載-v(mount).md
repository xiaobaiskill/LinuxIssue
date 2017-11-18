### 參考網站
https://docs.docker.com/engine/reference/builder/

### 命令用法
[可以先參考](https://github.com/jim0409/-Docker-/issues/2#issue-261625373)

#### 以docker run的情況下執行特定軟體
docker run -it --entrypoint /usr/bin/python3 images_python3_v1

執行docke run的情況下, 使用images_python3_v1開啟一個container並進入python3。

#### 以docker run的情況下執行特定軟體同時夾帶參數
docker run -it --entrypoint /usr/bin/java images_java_v1 -version

執行docke run的情況下, 使用images_java_v1開啟一個container並顯示其內容下的java版本。



### 如何使用mount
1. 首先在container內創造一個可以被外面掛載的資料夾 test_directory
2. 再外面建立一個要用作與內部test_directory連結的資料夾link_directory
(備註: 兩個資料夾可以同名, 在這僅為了方便所以才將兩個資料夾個別命名!!)

#### 選擇一個images執行docker run
docker run -it -v /外部資料夾路徑/link_directory:/內部資料夾路徑/test_directory/ images

如此一來便會執行一個container並且在進入後可以到"內部資料夾路徑"看到test_directory有著與link_directory同樣的內容物。

