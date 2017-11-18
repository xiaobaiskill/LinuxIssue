- 我是參考以下這篇文章
http://rocksaying.tw/archives/11239791.html

## 製作deb檔架構 (這邊我做了一個testdb資料夾下面放了DEBIAN & usr兩個資料夾)
ubuntu@ubuntu:~/DebTest/testdb$ tree
.
├── DEBIAN
│   └── control
└── usr
    └── bin
        └── hellJim

## control文件檔
control為一個可編輯文件, 需要涵括一些資訊如下;
> Package: 套件的名稱，在系統中必須是唯一的代號，慣例上用英文小寫與「-」組成
> Version: 套件版本號
> Architecture: 指定套件可執行的架構：例如 i368, amd64, sparc... 等等，也可以用 all 表示所有的平台皆可執行
> Maintainer: 維護者資訊
> Installed-Size: 安裝解壓縮後需要的磁碟空間
> Depends: 描述這個套件相依的其他套件，用來確保安裝後可以正確執行，非常好用

## usr/bin下的執行檔
其中hellJim是你想放入的執行檔(chmod +x hellJim), 這邊我是寫了一個echo "hell Jim"。

## 準備好上述檔案就可以執行打包指令dpkg -b (b : build)
dpkg -b ./testdb/ testdb_1.2.3.4.5.deb
打包完路徑下就會產生出 testdb_1.2.3.4.5.deb包！

以上, 有錯歡迎大神指教～

![2017-09-15 10 00 32](https://user-images.githubusercontent.com/22232508/30463157-c1d8720a-99fc-11e7-80a0-b327235d29e6.png)





Commetn by Elsvent

Control we can reference DRP

We have telegraf and smartmontool dependency
```
Source: drprophet
Section: unknown
Priority: extra
Maintainer: support <support@prophetstor.com>
Build-Depends: debhelper (>=9)
Standards-Version: 3.9.2
Homepage: http://www.prophetstor.com
#Vcs-Git: git://git.debian.org/collab-maint/drprophet.git
#Vcs-Browser: http://git.debian.org/?p=collab-maint/drprophet.git;a=summary

Package: drprophet
Architecture: any
Depends: ${shlibs:Depends}, ${misc:Depends}, sfcb (>= 1.4.9), slpd (>= 1.2.1), slptool (>= 1.2.1), sqlite3 (>= 3.7.9),
         apache2 (>= 2.2.22), libapache2-mod-php5 (>= 5.3.10), perl (>= 5.14), php5-sqlite (>= 5.3.10), php5,
         tzdata (>= 2014), logwatch, sblim-cmpi-common, sblim-cmpi-base, gawk, libcimcclient0 (>= 2.2.6), libcmpicppimpl0 (>=2.0.3),
         docker-engine (>= 1.11.2-0~trusty), drp-extra (>= 3.2), gdisk (>=0.8.1), nfs-kernel-server (>=1.2.5), wkhtmltox (>=0.12.2.1),
         ttf-wqy-zenhei (>=0.9.45-3.1ubuntu1), python-hivex (>=1.3.3), python-passlib (>=1.6.5)
Description: DRProphet server
  DR Prophet provides a total DR solution by securing user critical 
  data with local protection and remote offsite protection.

Package: drprophet-dbg
Architecture: any
Section: debug
Priority: extra
Depends: drprophet (= ${binary:Version}), ${misc:Depends}
Description: debugging symbols for drprophet
  DR Prophet provides a total DR solution by securing user critical 
  data with local protection and remote offsite protection.
  This package contains the debugging symbols for drprophet.
```

