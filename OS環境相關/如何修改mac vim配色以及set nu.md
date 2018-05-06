### 編輯 ~/.vimrc
vi ~/.vimrc
### 增添
```
" Configuration file for vim
set modelines=0 " CVE-2007-2438
 
" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible " Use Vim defaults instead of 100% vi compatibility
set backspace=2 " more powerful backspacing
 
" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup

syntax on
colo desert
```
### 保存後重新開啟vim

### 參考網址
http://www.vaughnemiller.com/2014/01/03/enabling-syntax-highlighting-for-vim-in-mac-os-x/
