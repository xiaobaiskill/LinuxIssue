# 參考rpm教學網站
http://tnrc.ncku.edu.tw/course/93/fedora_core2/page6/p6.htm

- 1. rpm -ivh : install(安裝), verbose(顯示) ,h(以###表示安裝進度)
- 2. rpm -ivh --force : --force(強制置換)
- 3. rpm -ivh --nodeps : --nodeps(強制執行)
- 4. rpm -e : -e(移除)
- 5. rpm -qa : qa顯示已經安裝的rpm

## 範例 
強制解除安裝python-2.7.5-16.el7.x86_64
> rpm -qa | grep python-2.7.5-16.el7.x86_64 | xargs rpm -e --nodeps
