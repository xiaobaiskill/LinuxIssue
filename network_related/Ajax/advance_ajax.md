# 使用ajax物件來執行http請求
模板
```
arr_data = [1, 2, 3, 4, 5];
$.ajax({
    url: '',                            // url位置
    type: 'post',                       // post/get
    async: true,                        // 預設為true，表示不同步
    tradition: true,                    // 預設為true，表示可以傳送陣列到Server端
    cache: true,                        // 預設為true，表示請求帶Cache-Control header: cache
    data: { querytag: arr_data },       // 輸入的資料
    error: function (xhr) { },          // 錯誤後執行的函數
    success: function (response) { }    // 成功後要執行的函數
});
```

實際請求(一)
```
e.g.
    var result = $.ajax({
	    url: '/cache.txt',
	    type: 'get',
        error: function(xhr){
            return false;
        },
        success: function (response){
            return true;
        }
    });

    console.log(result);

預期結果
{readyState: 1, getResponseHeader: ƒ, getAllResponseHeaders: ƒ, setRequestHeader: ƒ, overrideMimeType: ƒ, …}
abort: ƒ (e)
always: ƒ ()
catch: ƒ (e)
done: ƒ ()
fail: ƒ ()
getAllResponseHeaders: ƒ ()
getResponseHeader: ƒ (e)
overrideMimeType: ƒ (e)
pipe: ƒ ()
progress: ƒ ()
promise: ƒ (e)
readyState: 4
responseText: "{"jim":"jim"}↵"
setRequestHeader: ƒ (e,t)
state: ƒ ()
status: 200
statusCode: ƒ (e)
statusText: "OK"
then: ƒ (t,r,i)
__proto__: Object
```
> 註: result的值不是bool是，result是返回一個Object，從error、success兩個參數return的值看到，並不會指向給result，而是用console.log(result)輸出會看到的值是`$.ajax`方法的參數，像是`result.status`、`result.statusCode`、`result.statusText` ...

實際請求(二)
```
    $(function () {
        var result = GetData();
        console.log(result);
    });

    function GetData() {
        var result;
        $.ajax({
            url: '/cache.txt',
            type: 'get',
            error: function (xhr) {
                result = false;
            },
            success: function (response) {
                result = true;
            }
        });
        return result
    }

預期結果
w.fn.init [document]
VM594:3 undefined
```
因為`$.ajax方法預設為async:true啟動非同步方法`，也就是說並不會等`$.ajax執行完成`才return，所以這次return的值依舊並非我們所期望的`true`

# 使用aync:false // 啟動同步請求

實際請求(三)
```
e.g.
    $(function () {
        var result = GetData();
        console.log(result);
    });

    function GetData() {
        var result;
        $.ajax({
            async: false,
            url: '/cache.txt',
            type: 'get',
            error: function (xhr) {
                result = false;
            },
            success: function (response) {
                result = true;
            }
        });
        return result
    }

預期結果
w.fn.init [document]
VM599:3 true
```



# refer
https://dotblogs.com.tw/jasonyah/2013/06/02/use-ajax-you-need-to-be-care
https://api.jquery.com/jquery.ajax/
http://www.runoob.com/ajax/ajax-tutorial.html
http://www.w3school.com.cn/jquery/ajax_ajax.asp