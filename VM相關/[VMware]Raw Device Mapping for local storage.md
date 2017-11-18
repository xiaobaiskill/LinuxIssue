### 參考網址
https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1017530

### 步驟
1. 打開ESXi 上的SSH功能
2. 查看是否有可以直接做RDM的硬碟
- ls -l /vmfs/devices/disks
3. 從2. 的結果copy想要做RDM的disk後執行vmdk創建
4. 創建.vmdk
- vmkfstools -z /vmfs/devices/disks/diskname /vmfs/volumes/vmfolder/vmname.vmdk
(備註: diskname會被取代為類似代t10.F405E46494C4540046F455B64787D285941707D203F45765)
5. 開始創建VM
a. 右鍵點選想要編輯增加RDM硬碟的虛擬機器
b. 選擇Add（新增）
c. 選擇Hard Disk（硬碟）
d. 選擇Using an existing virtual disk（選擇既有的虛擬硬碟）
e. 選擇剛剛創建的vmname.vmdk後Next
f. Next -> Finish
