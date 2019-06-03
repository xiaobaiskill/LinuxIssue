# Use curl cmd to test REST service
REST service基於CRUE:
```
C: CREATE => POST
R: READ => GET
U: UPDATE => PUT
D: DELETE => DELETE
```
1. curl -X GET <- 使用GET方法
2. curl -X POST <- 使用POST方法
3. curl -X PUT <- 使用PUT方法
4. curl -X DELETE <- 使用DELETE方法

#### curl 夾帶其他常見參數header/ include/ data/ verbose/ user/ cookie
1. header: -H
> curl -H "testheader_name=testheader_value" <- 發送一個request請求時，夾帶一個header請求，該header為testheader_name對應值testheader_value
2. include: -i
> curl -i <- 發送請求出去後，返回請求得到的response header
3. data: -d (請求方法限定)
> curl -d "parm1=parm1_value" <- 發送一個request請求，夾帶參數data，該data為parm1對應值為parm1_value
> 補充
> 1. 常與POST並用，有時候又稱其為post body
> 2. 當使用參數型態表示，可以帶多個參數。e.g. curl -d "parm1=parm1_value" -d "parm2=parm2_value"
> 3. 當使用json型態表示，需要多帶一個header Content-Type: application/json。e.g curl -H "Content-Type: application" -d '"json1":{ "js1":"js1_v", "js2":"js2_v" }'
> 4. 當使用檔案時需要加入@表示檔案位置，假設存在一個檔案在/tmp資料夾下。名為data.json，其內容為'{"key1":"value1", "key2":"value2"}'，則curl -d '@/tmp/data.json'
> 5. 4.的方法等同於 curl -d '{"key1":"value1", "key2":"value2"}'
4. verbose: -v (排錯時使用，會顯示較多的訊息。不會改變request出去的參數)
5. user: -u (夾帶使用者帳號密碼，有時候可以放在querystring上)
6. cookie: -b
> 請求夾帶cookie。e.g. curl -b "cookie_name=cookie_value"
7. -L (Follow redirect): 通常訪問遇到301/302不會繼續接下去，下面的請求。會直接結束，加入`-L`可以在請求導轉後繼續往下請求，直到非3XX請求
8. -w (write) :配合notes裡面的檔案，可以紀錄該次curl請求的請求時間
> curl -w "@curl-format.txt" -s "https://example.com"


# reference:
1. http://blog.kent-chiu.com/2013/08/14/testing-rest-with-curl-command.html
2. https://gist.github.com/subfuzion/08c5d85437d5d4f00e58

3. https://curl.haxx.se/docs/http-cookies.html
4. https://stackoverflow.com/questions/15995919/how-to-use-curl-to-send-cookies


# notes:
curl-format.txt
```
time_namelookup:  %{time_namelookup}\n
       time_connect:  %{time_connect}\n
    time_appconnect:  %{time_appconnect}\n
   time_pretransfer:  %{time_pretransfer}\n
      time_redirect:  %{time_redirect}\n
 time_starttransfer:  %{time_starttransfer}\n
                    ----------\n
         time_total:  %{time_total}\n
```