# OSI 7LAYERS

OSI(Open System Interconnection Reference Mode)是由國際化標準組織(ISO)，針對開放式網路架構所制定的電腦互連標準
> 該模型是一種制定網路標準都會參考的概念性架構，並非一套標準規範
依據網路的運作方式，OSI模型共切分成7個不同的層級，分別為
1. 實體層
2. 資料連階層
3. 網路層
4. 傳輸層
5. 會一層
6. 展示層
7. 應用層

#### 第一層：實體層(Physical Layer)
- 實體層是OSI模型的最底層，他用來定義網路裝置之間的位元資料傳輸，像是電線或其他物理線材；傳遞0與1電子訊號，形成網路
> 實體層的規範：纜線的規格，傳輸速度，以及資料傳輸的電壓值，用來確保訊號可以再多種物理媒介上傳輸
```e.g. 網路線，網路卡與集線器，或Switching Hub(交換式集線器)```

#### 第二層：資料連結層(Data Link Layer)
- 資料連結層介於實體層與網路層之間，主要在網路之間建立邏輯連接，並在傳輸過程中處理流量控制及錯誤偵測
> 資料連結層將實體層的數位訊號封裝成一組符合邏輯傳輸資料，這組訊號稱為資訊框(Data Frame)。訊號框內包含媒體存取控制(Media Access Control，MAC)位址
> 資料在傳輸時，這項位址資訊可讓對方主機辨識資料來源。MAC位址是一組序號，每個網路設備的MAC位址都是獨一無二的，可以讓網路設備在區域網路溝通時彼此識別，例如網卡
> 非同步傳輸模式(Asynchronous Transfer Mode，ATM)以及點對點協定(Point-to-Point Protocol，PPP)，前者是早期網路發展的通訊協定，由於單次傳輸量很小，適合做語音傳輸；後者則是在我們使用ADSL時，會透過這項協定連接ISP，從而連上網際網路
```e.g. 網路交換器(Switch)是這個層級常見的設備，主要在區域網路上運作，能依據MAC位址，將網路資料傳送到目的主機上。交換器一般分為可設定式與免設定兩種，前者可以設定流量控制或設定子網路分割，後者僅傳書網路資料，不具其他進階功能```

#### 第三層：網路層(Network Layer)
> 網路層定義網路路由及定址功能，讓資料能夠在網路間傳遞。這一層最主要的通訊協定是網際網路協定(Internet Protocol，IP)
> 資料在傳輸時，該協定將IP位址加入傳輸資料內，並把資料組成封包(Packet)
> 在網路上傳輸時，封包裡面的IP位址會告訴網路設備這筆資料的來源及目的地
> 由於網路層主要以IP運作為主，故又稱作IP層。除IP，在網路層上運作的協定還包含IPX及X.25
```e.g. 路由器以及Layer3交換器，皆屬於第三層，主要以IP作為資料傳輸依據，大多在企業機房內運作。或是一些設備同時包含網路層功能，如IP分享器，及ADSL用戶終端設備(ADSL Terminal Unit-Remote，ATU-R)```

#### 第四層：傳輸層(Transport Layer)
> 傳輸層主要負責電腦整體的資料傳輸及控制，是OSI模型中的關鍵角色，他可以將一個較大的資料切割成多個適合傳輸的資料。替模型頂端的第五/六/七層等三個通訊層提供流量管制及錯誤控制
> 傳輸控制協定(Transmission Control Protocol，TCP)是我們常接觸具有傳輸層功能的協定，他在傳輸資料內加入驗證碼，當對方收到後。會依據驗證碼回傳對應的確認訊息(ACK)，若對方未即時傳回確認訊息，(以TCP來說)資料就會重新傳第一次，以確保資料傳輸的完整性

#### 第五層：會議層(Session Layer)
> 這個層級負責建立網路連線，等到資料傳輸結束時，再將連線中斷，運作過程有點像召集多人開會(建立連線)，然後彼此之間意見交換(資料傳輸)，完成後，宣布散會(中斷連線)
```e.g. NetBIOS names一種用來識別電腦使用NetBIOS資源的依據。或是開啟網路上的芳鄰時用到的"檔案及列印分享"，通常會看到群組及電腦名稱。這些就是NetBIOS names定義的```

#### 第六層：展示層(Presentation Layer)
> 應用層收到資料後，透過展示層可以轉換表達方式
```e.g. 將ASCII編碼轉成應用層可以使用的資料，或是處理圖片及其他多媒體檔案，如JPEG圖片檔或MIDI音效檔```

#### 第七層：應用層(Application Layer)
> 應用層主要功能是處理應用程式，進而提供使用者網路應用服務，這一層的協定較多
```e.g. DHCP(Dynamic Host Configuration Protocol)、FTP(File Transfer Protocol)、HTTP(HyperText Transfer Protocol)及POP3(Post Office Protocol-Version 3)等，依據不同的網路服務方式，這些協定能定義各自的功能及使用規範等細部規則```

#### 關於第七層的應用軟體
像是網路瀏覽器(ID、Firefox)、電子郵件、線上遊戲、即時通訊(MSN Messenger、ICQ)等

## 補充
除了OSI，最常使用的還是TCP/IP協定

#### 應用層(Application Layer):
應用程式間溝通的協定，如簡易電子郵件傳送(SMTP, Simple Mail Transfer Protocol)、檔案傳輸協定(FTP, File Transfer Protocol)、網路終端機模擬協定(TELNET)

#### 主機傳輸層(Transport Layer)：
提供端點間的資料傳送服務，如傳輸控制協定(TCP, Transmission Control Protocol)、使用者資料協定(UDP, User Datagram Protocol)等，負責傳送資料，並且確定資料已被送達並接收

#### 網際層(Internet Layer)：
負責提供基本的封包傳送功能，讓每一塊資料封包都能夠到達目的端主機(但不檢查是否正確接收)，如網際協定(IP, Internet Protocol)

#### 網路存取層(Network Access Layer)：
實質網路媒體的管理協定，定義如何使用實際網路(如Ethernet, Serial Line等)來傳送資料


# refer
- https://ithelp.ithome.com.tw/articles/10000021
