#### 如何在centos 6 下加入開機自動執行service
http://blog.xuite.net/tolarku/blog/373432865-CentOS+6+新增服務與開機自動執行+chkconfig+
> sudo chkconfig --add myService
> sudo chkconfig --list myService
> sudo chkconfig myService on

#### 如何在ubuntu 14.04下加入開機自動執行service
https://askubuntu.com/questions/9382/how-can-i-configure-a-service-to-run-at-startup
> sudo update-rc.d myService defaults

#### 同場加映 systemctl
https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units
> sudo systemctl enable application.service
