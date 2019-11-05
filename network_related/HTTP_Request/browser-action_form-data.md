# TL;DR(Too Long Don't Read)
結論，如果有二進制檔要傳送，使用multipart/form-data，否則使用application/x-www-form-urlencoded
> Summary; if you have binary (non-alphanumeric) data (or a significantly sized payload) to transmit, use multipart/form-data. Otherwise, use application/x-www-form-urlencoded.

# Form的enctype屬性為編碼方式，常見的有兩種
### application/x-www-form-urlencoded(預設)
- 當action為get時，瀏覽器用x-www-form-urlencoded的編碼方式把form資料轉換成一個字串(name1=value1&name2=value2...)，然後把字串append到url後面，用`?`分割，載入這個url。
- 當action為post時，`如果沒有type=file的控制元件，用預設的application/x-www-form-urlencoded`，瀏覽器把form資料封裝到http body中，然後傳送到server。

### multipart/form-data
- 當action為post時，`如果有type=file的控制元件，用multipart/form-data`，瀏覽器把form資料以控制元件為單位，並為每個部分加上Content-Disposition(form-data或者file)，Content-Type(預設為text/plain)，name(控制元件)等資訊，並加上分割符號(boundary)



# refer:
- https://www.itread01.com/content/1546299749.html
- https://stackoverflow.com/questions/4007969/application-x-www-form-urlencoded-or-multipart-form-data