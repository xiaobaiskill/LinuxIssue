# motivation
在使用Jenkins時，需要freeStyle來執行特殊指令，屆時需要透過sudo權限，會遇到權限不足的問題。

# run sudo without password
1. 編輯`/etc/sudoers`，並且在該文檔底下加入一個不需要sudo的使用者
   > sudo vi /etc/sudoers
2. 跳至最後一行並且插入
   > jenkins ALL=(ALL) NOPASSWD:ALL

# refer:
- https://www.cyberciti.biz/faq/linux-unix-running-sudo-command-without-a-password/