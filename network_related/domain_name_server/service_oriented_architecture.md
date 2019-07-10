# Service Oriented Architecture(SOA)
SOA是一種架構模型，由網站服務技術等標準化元件組成

# SOA如何運作
SOA通常包括，軟體元件、服務及流程三個部分，SOA具有下列技術特性
1. 分散式(distributed) - SOA的組成元件是由許多分散在網路上的系統組合而來，可能是區域網路，也可能是來自廣域網路。例如網站服務技術(web services)就是運作HTTP來相互連結的SOA
2. 關係鬆散的介面(loosely coupled) - 傳統的系統主要是將應用系統功能需求切割成相互關聯的小零組件：模組、物件或元件。SOA的做法是以界面標準來組合系統，只要符合界面要求，零組件可以任意替換，大幅提高系統變更的彈性度
3. 依據開放的標準(Open standard) - 使用開放標準是SOA的核心特色，過去的軟體元件平台如CORBA、DCOM、RMI、J2EE採用專屬協定作為元件連結的規範，使得不同平台的元件無法相通。SOA則著重於標準與互動性，將可避免不同平台(.NET web services與Java web services)開發城市間相互整合的困繞
4. 以流程角度出發(process centric) - 在建構系統時，首先了解特定工作的流程要求，並將其切割成服務界面(包括輸入與輸出資料格式)，如此其他的發展者就可以依據服務界面開發(或選擇)合適的元件來完成工作


# SOA流程管理3要素
1. SOA註冊庫(SOA Registry): 記錄所有元件的相關資訊
2. 流程引擎(Workflow Engine): 負責元件及流程間的訊息傳遞
3. 服務仲介(Service Broker): 在流程執行過程中，確認流程引擎是否依元件的相關資訊正確傳遞訊息
三者皆透過企業服務匯流排(Enterprise Service Bus ; ESB)介面進行資訊傳遞

為了釐清企業內部所有的商業服務，確實呈現相關的流程及核心價值，以定義其中所包含的元件，因此需要SOA治理(SOA Governance)的功能，而所有和SOA治理相關的資訊，則存在SOA資產庫(SOA Repository)中，強調的是商業行為管理的概念

# refer:
- http://www.cc.ntu.edu.tw/chinese/epaper/20070620_1008.htm
- https://www.digitimes.com.tw/tw/dt/n/shwnws.asp?cnlid=&id=0000123327_9xh202g93w4ldb6tsy8dg
- https://zh.wikipedia.org/wiki/%E9%9D%A2%E5%90%91%E6%9C%8D%E5%8A%A1%E7%9A%84%E4%BD%93%E7%B3%BB%E7%BB%93%E6%9E%84