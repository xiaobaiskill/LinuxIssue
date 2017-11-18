## 參考網站
> http://t20301sses.blogspot.tw/2016/02/ova.html

> 備註1. VirtualBox的ova檔無法直接與VMware共用。這邊是在vSphere上建立ova檔。
> 備註2. 安裝vm如果無法直接ssh可以嘗試安裝 apt-get install openssh-server
> 備註3. 安裝vm之iso檔上傳流程 vSphere > Inventory > Summary > Storage > [right click] upload file
[ 右鍵點選 Storage ]
![2017-09-18 2 42 27](https://user-images.githubusercontent.com/22232508/30531270-b7c5bc66-9c7f-11e7-9221-41d3c09bc30c.png)
[ 選擇上傳本機已經下載好的iso ]
![2017-09-18 2 42 42](https://user-images.githubusercontent.com/22232508/30531266-b460b29c-9c7f-11e7-9033-ecf24bb12602.png)




## export OS to .ova
1. 製作ova前先將光碟退出, 不然會出現無法匯入的情況。
> a. 在虛擬機器上點選右鍵, 選擇Edit Settings
![2017-09-18 3 48 11](https://user-images.githubusercontent.com/22232508/30533868-20db2408-9c8e-11e7-9847-2909cf4db0c6.png)
> b. 選擇Host Device
![2017-09-18 3 48 31](https://user-images.githubusercontent.com/22232508/30533935-7de94148-9c8e-11e7-85d7-70b027472680.png)

2. 先選取要Export的機器, 再點選File下的Export > Export OVF Template
![2017-09-18 3 16 25](https://user-images.githubusercontent.com/22232508/30533993-cf22e118-9c8e-11e7-8536-c7cb3bbd56dd.png)

3. 點選Directory旁邊的 ... 按鈕 去指定要存放的OVF/ OVA位置
![2017-09-18 3 20 43](https://user-images.githubusercontent.com/22232508/30534041-fd3b2042-9c8e-11e7-9acc-ffc1a2c7736b.png)

4. 在這邊選擇OVA
![2017-09-18 3 21 16](https://user-images.githubusercontent.com/22232508/30534058-0e50dec6-9c8f-11e7-8ca5-659a7b210b17.png)

5. 按下 OK 會自動開始執行製作OVA



## import .ova
1. 選擇File >Deploy OVF Template... 
![2017-09-18 3 39 06](https://user-images.githubusercontent.com/22232508/30535635-976e64ca-9c95-11e7-8cb0-0df5bc2b9290.png)
2. 選擇要製作的OVF/ OVA檔案
![2017-09-18 3 39 40](https://user-images.githubusercontent.com/22232508/30535700-c35dfff0-9c95-11e7-9bd8-5767183af1b1.png)
3. 後面基本上只要點選Next就能完成一台VM了。
> 確認系統設定
![2017-09-18 3 40 03](https://user-images.githubusercontent.com/22232508/30536018-dc6b5410-9c96-11e7-995d-3bcbdf733c42.png)
> 創造VM名字確認
![2017-09-18 3 40 21](https://user-images.githubusercontent.com/22232508/30536030-e83cf44c-9c96-11e7-900b-4a190ec60da8.png)
> 選擇該VM要使用的Disk資源
![2017-09-18 3 40 29](https://user-images.githubusercontent.com/22232508/30536054-fd14257a-9c96-11e7-9084-85233b5b2979.png)
> 選擇預設的Thick Provision Lazy Zeroed即可
![2017-09-18 3 40 38](https://user-images.githubusercontent.com/22232508/30536064-05cc282a-9c97-11e7-960d-57207215408b.png)
> 最後一步Finish按下去就會創造出VM了！
![2017-09-18 3 40 47](https://user-images.githubusercontent.com/22232508/30536112-2e929e7e-9c97-11e7-9f3d-5c5c9cda5b0f.png)

