## 以golang實做gRPC server以及client

### 介紹
##### 在此會簡單介紹proto編寫的一些規定，至於為何要用.proto而不用xml在此不多做贅述;可參考下連結Working with Protocol Buffers
> https://grpc.io/docs/guides/ ; 以下文本範例主要是參照網頁https://developers.google.com/protocol-buffers/docs/proto3
如有不清楚或錯誤之處還煩請提出！感謝～

##### proto2 vs proto3
> 官方建議使用proto3避免未來會有proto3版本不接納proto2的版本問題，所以必須在.proto file的第一段加上
```
syntax = "proto3";
```

##### 透過.proto 檔在pb.go(IDL)宣告一個變數
> 變數以enum的方法進行宣告，宣告一個變數（不論類別）即必須給予一個對應的數字~
> 使用的變數型別(int32, int64, string, ...)請參照：https://developers.google.com/protocol-buffers/docs/proto3#scalar
```
e.g.
message SearchRequest {
  string query = 1;
  int32 page_number = 2;
  int32 result_per_page = 3;
}
```

##### repeated用法;(required/ optional are no longer support proto3) 
> repeated: 表示這個變數名稱可能會在該.proto檔內被使用多次。
```
// 使用SearchResponse內含有使用Result這個結構的results;results可能在被轉為.pb.go後被大量使用。
message SearchResponse {
  repeated Result results = 1;
}

message Result {
  string url = 1;
  string title = 2;
  repeated string snippets = 3;
}
```
> 同上，巢狀架構寫法
```
message SearchResponse {
  message Result {
    string url = 1;
    string title = 2;
    repeated string snippets = 3;
  }
  repeated Result results = 1;
}
```
##### 透過.proto檔在.pb.go(IDL)裡面宣告一個enum變數
> 可參照enum的用法：https://developers.google.com/protocol-buffers/docs/proto3#enum
```
message SearchRequest {
  string query = 1;
  int32 page_number = 2;
  int32 result_per_page = 3;
  // enum 為資料型別;Corpus 為變數名稱
  enum Corpus {
    UNIVERSAL = 0;
    WEB = 1;
    IMAGES = 2;
    LOCAL = 3;
    NEWS = 4;
    PRODUCTS = 5;
    VIDEO = 6;
  }
  // 需要額外在enum 外定義資料結構為Corpus的變數corpus好讓SearRequest這個資料結構可以看到Corpus變數
  Corpus corpus = 4;
}
```
> 如何在enum中使用重複的變數名稱
```
enum EnumAllowingAlias {
  // 使用預設的參數allow_alias並選擇true 
  option allow_alias = true;
  UNKNOWN = 0;  // <- 重複使用
  STARTED = 1;  // <- 重複使用
  RUNNING = 1;
}
enum EnumNotAllowingAlias {
  UNKNOWN = 0;  // <- 重複使用
  STARTED = 1;  // <- 重複使用
}
```
> 針對go語言如何轉換成實際要用的變數可以參考，https://developers.google.com/protocol-buffers/docs/reference/go-generated#singular-scalar-proto3

##### 在.proto 檔宣告可能會用到的interface
> 1. 先定義出一個service
```
service class_interface{
...
}
```
> 2. 在service內定義出會用到methods
```
// 類型1.simple RPC;client端用該method詢問server得到response後結束該method
rpc NeededMethod(InputPtr) returns (OutputFeature) {}

// 類型2.server端streaming RPC;client端使用該method詢問server端得到一個stream，
// client可以藉由這個stream讀取數據直到沒有數據可讀。
rpc ListFeatures(Rectangle) returns (stream Feature) {}

// 類型3.client端streaming RPC;client端使用一個stream將一系列數據發送給server端，
// 直至client端將數據發送完畢後server端會反饋一個完畢訊息。
rpc RecordRoute(stream Point) returns (TrouteSummary) {}

// 類型4.雙向streaming RPC;client端以及server端彼此兩邊透過讀寫流(read-write stream)向對方發送一系列訊息。
// 兩邊的stream都是獨立的，所以client端和server端可以隨意地進行讀寫操作;
// 例如server端可以等待client端的數據都接收完畢後再回饋response給client裡寫數據。反之亦然。
rpc RouteChat(stream RouteNote) returns (stream RouteNode) {}
```
> reference : https://grpc.io/docs/tutorials/basic/go.html

##### 在.proto 檔實現structue概念
> 先宣告一個message並且賦予其一定的變數，在使用令一個message承接上一個message所使用的物件。
```
message SearchResponse {
  repeated Result results = 1;
}

message Result {
  string url = 1;
  string title = 2;
  repeated string snippets = 3;
}
```

##### 如何在.proto檔案中加入註解
> 如同C/C++的形式，使用'//'或'/* ... */'來做註解


##### 後續想到補充會繼續寫
```
... to be continued!
```

### 實做
##### 基礎範例，使用go語言從.proto file到實做（此處不解釋如何編譯proto.file)
1. 定義一個.proto file
2. 使用proto buffer complier (需要先下載proto3，可參考：https://gist.github.com/sofyanhadia/37787e5ed098c97919b8c593f0ec44d8)
3. 使用指令protoc --go_out=plugins=grpc:. helloworld.proto 產生出helloworld.pb.go檔，可以作為之後要使用的interface
- 備註 1. '.' 是代表檔案位置，此處我是移動放置.proto資料夾內執行該行指令。 
- 備註 2. 'helloworld.proto' 請換成對應的proto檔
- 備註 3. 'go_out=plugins=grpc:' 為固定用法，其旨是要把.proto file轉成.go檔
- 備註 4. .proto檔可以import其他package，在使用protoc轉檔時可另外加-I將import的package路徑加入。
(https://developers.google.com/protocol-buffers/docs/proto3#importing-definitions)
4. 開兩個資料夾，分別命名為server以及client並且在裡面放置main.go作為執行時使用。
5. 定義好server/main.go，執行可以帶起一個server。(保持running)
6. 定義好client/main.go，執行可以得之前定義好的method所對應的response
> gRPC提供的範例：https://github.com/grpc/grpc-go/tree/master/examples

### extend
fix protoc bug
1. install protoc again with cli : `sh install_protoc_on_ubuntu_sh`
2. update prot0 & protoc-gen-go ith cli : `go get -u github.com/golang/protobuf/{proto,protoc-gen-go}` 

# refer
1. golang return error with ` undefined: proto.InternalMessageInfo`
- https://blog.csdn.net/busai2/article/details/82805788

2. 高版本protoc搭配低版本protobuf
- https://www.cnblogs.com/mind-water/articles/10399995.html


### About protoc generates *.pb.go without methods included in files
1. execute cli
> protoc --go_out=plugins=grpc: .

2. checkfile ... only includes `struct` and no methods included ...
refer:
- https://askubuntu.com/questions/1072683/how-can-i-install-protoc-on-ubuntu-16-04

3. finall success with cli:
> sudo apt install protobuf-compiler

