# XML-可延伸標記式語言
Extensible Markup Language，簡稱XML，是一種標記式語言。透過標記以及一定的資料結構規範來傳送及攜帶資訊。

# Big Words
1. 字元(characters) XML規範允許的(跳脫後的最終解碼值)合法字元：
    1. #x9(水平制表符)
    2. #xA(Enter符號))
    3. #xD(換行符號)
    4. #x20-#xD7FF
    5. #xE000-#xFFFD
    6. #x10000-#x10FFFF

2. 處理器(Processor)與應用(application): XML處理器(Processor，也稱作XML parser)分析標記式語言並傳遞結構化資訊給應用(application)

3. 標記(Markup)與內容(content):XML文件的字元分為標記(Markup)與內容(content)兩類。標記通常以`<`開頭，以`>`結尾;或者以`&`開頭，以`;`結尾。不是標記的字元就是內容。但是CDATA部分，分解符號`<![CDATA[and]]>`是標記，兩者之間的文字為內容。最外界的空白符號不是標記。

4. 標籤(Tag):一個tag屬於標記結構，以`<`開頭，以`>`結尾。Tag名字是大小寫敏感，不能包括任何字元
```
!"#$%&'()*+,/;<=>?@[\]^`{|}~
```
也不能有空格符號，不能以"-"或"."或數字開始，可分為三類；
    1. start-tag, 如<section>
    2. end-tag, 如</section>
    3. empty-element tag, 如<line-break />

5. 元素(Element):元素是文件邏輯組成，或者在start-tag與符號的end-tag之間，或者僅做一個empty-element tag。例如:<greeting>Hello, World!</greeting>.另一個例子是:<line-break />.單個根(root)元素包含所有的其他元素

6. 屬性(Attribute):屬性是一種標記結構，在start-tag或empty-element tag內部的"名字-值對"。例如:<img src="madonna.jpg" alt="Madonna" />。每個元素中，一個屬性最多出現一次，一個屬性只能有一個值。如果屬性有多個值，這需要採取XML協定以外的方式來表示，如採用逗號或分號間隔，對於CSS類或識別元的名字可用空格來分隔。

7. XML聲明(declaration):XML文件如果以XML declaration開始，則表述了文件的一些資訊。如<?xml version="1.0" encoding="UTF-8">

# example
XML定義結構、儲存資訊、傳送資訊
```
e.g.

<?xml version="1.0"?>
<little note>
  <receiver>jim</receiver>
  <sender>jim_weng</sender>
  <title>test_title</title>
  <content>Hello, World! Jim.</content>
</little note>

```

# structure
1. 每個XML都是由XML序言開始，在前面的程式碼中的第一行為<?xml version="1.0"?>告訴解析器或瀏覽器，這個檔案應該按照XML規則進行解析
2. 每個標籤的種類需要符合文件類型定義(DTD)或XML綱要(XML Schema)定義
3. XML檔案的第二行並不一定要包含文件元素，如果有註釋或者其他內容，文件元素可以延後出現
4. 最常見的PI(Processing Instruction，像XML序言，卻是不同類型的語法)是用來指定XML檔案的樣式表，這個PI一般會直接放在XML序言之後，通常由Web瀏覽器使用，來將XML資料以特殊的樣式顯示出來
5. XML的結構有一個缺陷，寄售不支援分影格(framing)。當多條XML訊息在TCP上傳書的時候，無法基於XML協定來確定一條XML訊息是否已經結束

# refer
https://zh.wikipedia.org/wiki/XML
https://sls.weco.net/node/10554
https://dotblogs.com.tw/johnny/archive/2010/01/25/13303.aspx
https://stackoverflow.com/questions/4920877/xml-how-to-create-run-xml-file
https://javatoybox.blogspot.com/2018/06/xml-1.html