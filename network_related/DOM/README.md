# DOM (Document Object Model)
DOM，文件物件模型，是W3C組織推薦的處理`可延伸標示語言`的標準程式介面

W3C聯合各瀏覽器廠商制訂了標準物件模型，試圖讓各瀏覽器廠商遵合此一模型進行實作，以解決各瀏覽器間物件模型不一致的問題，在新的物件模型中，也對文件操作的功能加以擴充

# 為何需要DOM
網頁是由瀏覽器負責運行，因此可以知道瀏覽器其實就是一種編譯器，負責去編譯寫好的網頁程式
> 因為有很多公司都在設計瀏覽器，如果沒有事先定好規則，讓各家瀏覽器去遵從，可能會導致錯亂，因此W3C定義了一些網頁規則，好讓瀏覽器廠商去按照規則設計瀏覽器，其中DOM就是一項設計規定

# DOM架構
一份標準的DOM文件，所有的標籤定義，包括文字都是物件，這些物件以文件定義的結構形成一個樹狀結構
> 而樹狀結構最著要的就是個個 "節點"(node)

```
e.g.
<html>
    <head>
        <title>home page</title>
    </head>
    <body>
        <h1>Hello!World!</h1>
        <a href="Goosip/index.html">notes</a>
    </body>
</html>
```

這份HTML文件，會形成以下樹狀的物件結構：
```
document                    (Document)
    |-html                  (HTMLHtmlElement)
    |   |-head              (HTMLHeadElement)
    |       |-title         (HTMLTitleElement)
    |           |-homepage  (Text)
    |
    |body                   (HTMLBodyElement)
       |-h1                 (HTMLHeadingElement)
       | |-Hello!World!     (Text)
       |
       |-a                  (HTMLAnchorElement)
         |-notes            (Text)
```
- (Document): Document就是指這份文件，也是這份HTML檔的開端，所有的一切會從Document開始往下進行
- (Element): Element就是指文件內的各個標籤，因此像是<div>、<p>等等各種HTML Tag都是被歸類在Element裡面
- (Text): Text是指被標籤包起來的文字`Hello!World!`在這邊就是被`h`包起來，所以`h`示標籤`Hello!World!`是文字
- (Attribute): Attribute是指各個標籤內的相關屬性

# DOM遍歷
由於DOM為樹狀結構，樹狀結構最重要的觀念就是Node彼此之間的關係，基本可以分為
1. 父子關係(Parent and Child)
   1. 簡單來說就是上下層節點，上層為Parent Node，下層為Child Node
2. 兄弟關係(Siblings)
   1. 簡單來說就是同一層節點，彼此間只有Previous以及Next兩種

# DOM操作 - 基本常用DOM API
- document.getElementById('idName')
  - 找尋DOM中符合此`id`名稱的元素，並回傳相對應得element
- document.getElementsBytagName('tag')
  - 找尋DOM中符合此`tag`名稱的所有元素，並回傳相對應的`element集合`，集合為`HTMLCollection`
- document.getElementsByClassName('className')
  - 找尋DOM中符合此`class`名稱的所有元素，並回傳相對應的`element集合`，集合為`HTMLCollection`
- document.querySelector('selector')
  - 利用`selector`來找尋DOM中的元素，並回傳相對應的第一個`element`
- document.querySelectorAll('selector')
  - 利用`selector`來找尋DOM中的所有元素，並回傳`相對應的第一個element`，集合為`NodeList`

# 兩個Collection of DOM Nodes 的比較 `HTMLCollection` 以及 `NodeList`
- HTMLCollection:
  - 集合內元素為HTML element，也因此Node type只接受Element
- NodeList:
  - 集合元素為Node，因此全部的Node都可以存放在NodeLists內
> 近期因為jQuery盛行，讓HTML與JavaScript的溝通更佳精簡，也因此越來越多人捨棄DOM API進而頭像jQuery的懷抱...

`()`代表每個物件的型態，document代表整個文件，而不代表html節點

以上面例子來說，使用document.documentElement來取得html元素

可以使用`document.childNodes[0]`取得html元素，`childNodes`表示取得子節點，取回的會是`NodeList`物件，是個類似陣列的物件，可使用`索引值`來指定取得某個子節點

方便的`document.documentElement`也可用來取得html元素。如果想取得body元素，也可以透過document.body來取得(notes: 文字也會形成樹狀結構中的元素)

儘管看到的元素形態中，有許多都是帶有HTML字眼，但`DOM並非專屬於HTML的物件模式`，DOM API分為兩部份，一個是`核心 DOM API`，一個是`HTML DOM API`

> 核心API是一個圖利的規範，可以用任何語言實現，可操作的對線是基於XML的任何物件
> HTML API是核心API的延伸，專門操作HTML，各種物件對應的型態，通常會有個HTML字眼在前頭

核心API文件中所有內容都視為節點，包括文件本身，再一類型區分出不同的形態:
```
Node
   |Document
   |Element
   |Text
   |Attr
   ...
```
Document代表整份文件，Element是所有標籤(也是節點)，Text代表文字元素(也是節點)

Level 0 DOM在window物件上有navigator、location、frames、screen、history等與瀏覽器相關的物件，與萬件相關的物件，實際上只有document，功能也有限，這個部分納入了DOM標準，成為DOM的子集

每個節點都會有nodeName與nodeType特性，前者可以取得節點的名稱，後者可以取得節點型態常數
```
e.g.
<html>
    <head>
        <meta content="text/html; charset=UTF-8" http-equiv="content-type">
        <script type="text/javascript">
            window.onload = function() {
                var typeNames = [
                    '',
                    '[ELEMENT_NODE]',
                    '[ATTRIBUTE_NODE]',
                    '[TEXT_NODE]',
                    '[CDATA_SECTION_NODE]',
                    '[ENTITY_REFERENCE_NODE]',
                    '[ENTITY_NODE]',
                    '[PROCESSING_INSTRUCTION_NODE]',
                    '[COMMENT_NODE]',
                    '[DOCUMENT_NODE]',
                    '[DOCUMENT_TYPE_NODE]',
                    '[DOCUMENT_FRAGMENT_NODE]',
                    '[NOTATION_NODE]'
                ];
                
                function list(parent, indent) {
                    var nodes = parent.childNodes;
                    var tree = [];
                    for(var i = 0; i < nodes.length; i++) {
                        tree.push(indent + nodes[i].nodeName + 
                                  typeNames[nodes[i].nodeType] + '<br>');
                        tree.push(list(nodes[i], '　　' + indent));
                    }
                    return tree.join('');
                }
                
                document.getElementById('console').innerHTML = 
                   'document' + typeNames[document.nodeType] + 
                   '<br>' + list(document, '　　');
            };
        </script>
        <title>首頁</title>
    </head>
    <body>
        <h1>Hello!World!</h1>
        <a href="https://openhome.cc/Gossip/">學習筆記</a>
        <div id="console"></div>
    </body>
</html>
```

# 總結
DOM是一種觀念，為了不讓網頁再渲染的過程中過度的`重畫頁面(Repaint)`甚至是`重構頁面(Reflow)`而產生

# refer
https://zh.wikipedia.org/wiki/%E6%96%87%E6%A1%A3%E5%AF%B9%E8%B1%A1%E6%A8%A1%E5%9E%8B
https://openhome.cc/Gossip/JavaScript/W3CDOM.html
https://ithelp.ithome.com.tw/articles/10202689
https://developer.mozilla.org/zh-TW/docs/Glossary/DOM
https://developer.mozilla.org/zh-TW/docs/Web/API/Document_Object_Model