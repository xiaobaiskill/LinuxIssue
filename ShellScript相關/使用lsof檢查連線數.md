# lsof (LiSt Open Files)
LiSt Open Files(LSOF) 是一個Linux utility，支持使用者觀察近期的網路連接，以及往爐連接相關檔案

用於排查`程式操作哪些公開的port`，或者`背景應用建立了哪些連線`，以及`哪些port在伺服器上已經被開啟了`。

其他有許多類似的排查工具，像是`netstat`、`ss`及`fuser`。但losf為linux預設的，可以透過losf -v來觀察有什麼程序在你的電腦中執行

# 常用指令
1. lists all open files associated with Internet connections.
> lsof -i : 列出所有的與網路關聯的資料，等同於 `netstat -a -p`
2. specifying a particular port, service, or host name using
- port
> lsof -i :587
- service
> lsof -i :smtp
- host name
> lsof -i @labrat.remote.net
3. accept a PID(409) and output all open files it is using
> lsof -p 409

# refer:
- https://www.techrepublic.com/article/track-network-connections-with-lsof-on-linux/


# extend-refer:
>  fuser - list process IDs of all processes that have one or more files open
