# 安裝apache
1. sudo yum update httpd
2. sudo yum install httpd mod_ssl
3. 到目錄`/etc/httpd/conf`下修改httpd.conf
4. 在檔案`httpd.conf`下增加設定
```httpd.conf
ProxyRequests On
ProxyVia On
SSLProxyEngine On

<Proxy *>
    Order deny,allow
    Deny from all
    Allow from 允許的IP e.g. 123.123.213.0/24 132.231.123.123
#    Allow from all # 允許所有的設定
</Proxy>
```

# refer:
- https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-centos-7
- http://dev.antoinesolutions.com/apache-server/mod_ssl