##### 在此會簡單介紹proto編寫的一些規定，至於為何要用.proto而不用xml在此不多做贅述;可參考下連結Working with Protocol Buffers
> https://grpc.io/docs/guides/ ; 以下文本範例主要是參照網頁https://developers.google.com/protocol-buffers/docs/proto3，如有不清楚或錯誤之處還煩請提出！感謝～

##### proto2 vs proto3
> 官方建議使用proto3避免未來會有proto3版本不接納proto2的版本問題，所以必須在.proto file的第一段加上
```
syntax = "proto3";
```

##### .proto 檔宣告變數
> 變數以enum的方法進行宣告，宣告一個變數（不論類別）即必須給予一個對應的數字~
```
e.g.
message SearchRequest {
  string query = 1;
  int32 page_number = 2;
  int32 result_per_page = 3;
}
```
> 可參照enum的用法：https://developers.google.com/protocol-buffers/docs/proto3#enum

##### 如何在.proto檔案中加入註解
> 如同C/C++的形式，使用'//'或'/* ... */'來做註解


##### 後續
```
... to be continued!
```


##### 基礎範例，使用go語言從.proto file到實做（此處不解釋如何編譯proto.file)
1. 定義一個.proto file
2. 使用proto buffer complier (需要先下載proto3，可參考：https://gist.github.com/sofyanhadia/37787e5ed098c97919b8c593f0ec44d8)
3. 使用指令protoc --go_out=plugins=grpc:. helloworld.proto 產生出helloworld.pb.go檔，可以作為之後要使用的interface
- 備註 1. '.' 是代表檔案位置，此處我是移動放置.proto資料夾內執行該行指令。 
- 備註 2. 'helloworld.proto' 請換成對應的proto檔
- 備註 3. 'go_out=plugins=grpc:' 為固定用法，其旨是要把.proto file轉成.go檔
4. 開兩個資料夾，分別命名為server以及client並且在裡面放置main.go作為執行時使用。
5. 定義好server/main.go，執行可以帶起一個server。(保持running)
6. 定義好client/main.go，執行可以得之前定義好的method所對應的response
> gRPC提供的範例：https://github.com/grpc/grpc-go/tree/master/examples
