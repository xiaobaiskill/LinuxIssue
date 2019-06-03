# XML基本語法(Syntax)
- tag
- notes
- Well-formed
- Entity Reference
- Built-in Entity
- CDATA
- Namespace
- 中文標記及內容
  
## tag
html的標籤是呈現文件的佈局和外觀，但是xml的標籤可以自己訂定，定義標籤按照自己的意思來表打內容，而且可以是中文，方便編譯者閱讀。
```
e.g.

<code>
<laptop>mac</laptop>
<language>C</language>
</code>
```

## notes
如果要加入註解，語法:
`<!--註解-->`
註解可以加在任何位置，但不能加在標籤之間

## Well-formed
良好的格式要求是
1. 在文件的第一行必須宣告XML版本(及必要時得編譯語言`encoding`)，例<?xml version="1.0" encoding="utf-8"?>
2. 文件中必須含有一個root標籤。以範例來說<code>就是root標籤
3. 期使標籤和結束標籤一定要是成對的e.g. <code>...</code>
4. 空標籤(empty)要以`/>`結尾，e.g. HTML標籤中的<img src="img.gif" />
5. 標籤要巢狀排列，不可交錯。e.g <code><laptop>mac</laptop></code>
6. 英文字母大小寫是有區別的(case sensitive)
7. 屬性要用雙引號框住 e.g. <student age="20">
8. 相同屬性在同一標籤只能出現一次 error example <code><code>content</code></code>

## Entity reference
XML有些符號是有特殊功能的，為了防止瀏覽器或其他城市堵曲的時候無法辨識。但是又要在螢幕上顯示出來的時候就需要用Entity Reference來實現

## Built-in Entity
預設系統的保留字以及對應的表，表示方式/顯示符號: 
```
&lt;    /   <
&gt;    /   >
&amp;   /   &
&quot;  /   "
&apos;  /   '
```

## CDATA(character data)
```
<script>
    <![CDATA[
        function matchwo(a,b){
            if (a < b && a < 0) then{
                return 1;
            }else{
                return 0;
            }
        }
    ]]>
</script>
```
1. 一般來說，如果文件內容出現<`>符號的時候會被parser解析，如果沒有轉成上述的&it或&gt的話就會出現錯誤
2. 使用<![CDATA[ ... ]]>之間的文字會背當成字元，原封不動的處理。包含空白和換行，parser不會去解析裡面的標記

## Namespace
XML namespaces提供`方法`防止使用者命名的時候有衝突
- 每一個namespace之前都用一個URI(uniform resource identifier)來個別定義namespace
```
e.g.
<school:subject>Math</school:subject>
<mediical:subject>Music</mediical:subject>
`school`及`medical`都是namespace prefixes
```

- 每個namespace之前都用一個URI(uniform resource identifier)來個別定義namespace
  - create namespace:
  - 用xmlns這個關鍵字
  - 例如:
    ```
    xmlns:text="urn:deitel:texInfo"
    xmlns:image="urn:deitel:imageInfo"
    ```
  - 在文件內的運用
    ```
    <text:file fileName="book.xml">
    <image:file fileName="funny.gif">
    ```
以例子來看:urn:deitel:tectInfo就是text這個prefix的URI
- URI是由一連串不同名字的字元所組成
- 創立XML者可以自行定義它們自己的namespace prefixes
- 任何名字都能作為namespace prefix，但是namespace prefix xml在XML使用的標準裡是被保留的

##### 為了估計每個XML所需要的namespace prefix，建立者可以定義一個default namespace作為一個元素和他的子元素
- 當我們宣告一個default namespace的時候我們必須使用keyword xmlns並以一個URI(Uniform Resource Identifier)作為他的值
    ```
    e.g.
    <directory xmlns = "urn:deitel:textInfo"
     xmlns:image = "urn:deltel:imageInfo">
    ```
    如果在文件中，以這兩個例子來看
    ```
    <file fileName="book.xml"> <- 這個就會用default
    <image :file fileName="funny.gif">
    ```
    - 文件的建立者通常會使用URLs(Uniform Resource Locators)來代替URIs，因為預設的名字通常是獨一無二的(e.g., deitel.com)

## 中文標記及內容
XML規範中，內定字集是Unicode並要求所有XML的應用軟件都支持UTF-8和UTF-16字集。要使用中文，XML文件的第一句要加上encoding="BIG5"
```
<?xml version="1.0" encoding="BIG5"?>
```
那麼整份文件也可以使用中文了(包括標記及內容)

# refer
https://sls.weco.net/node/10554
https://dotblogs.com.tw/johnny/archive/2010/01/25/13303.aspx
https://javatoybox.blogspot.com/2018/06/xml-1.html
https://www.w3schools.com/xml/schema_intro.asp
https://www.w3schools.com/xml/xml_validator.asp