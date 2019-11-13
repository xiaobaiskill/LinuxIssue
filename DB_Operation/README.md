# 參照的SQL指令教學網址
https://www.1keydata.com/tw/sql/sql.html

# online SQL editor
https://www.w3schools.com/sql/trysql.asp?filename=trysql_op_in

# 常用指令
1. select : 選表欄用
2. as : 將database宣告為某一變數方便後面做有效宣告
3. from : 表示使用哪個database
> select a.OrderID,sum(a.OrderID) from Orders a;

4. where : 用於下判斷式，特別是搭配{in, between, and, or}
> SELECT * FROM OrderDetails where OrderID > 10500 or (ProductID > 70 and Quantity > 10);

5. order by (desc): 將顯示出來的結果做排序，desc表示反排序。
6. like : 可以配合特殊字元'%'用篩選欄位資料
> SELECT * FROM OrderDetails where OrderID like '%50';

# 關聯名詞
記錄一些在敘述表格常用的名詞解釋，關聯式資料模型 SQL Server/Access

| 常用名詞| 對應名詞|
|---|---|
| 關聯(Releation)| 表格(Table)|
| 值組(Tuple)| 橫列(Row) or 紀錄(Record)|
| 屬性(Attribute) |直欄(Column) or 欄位(Field)|
| 基數(Cardinality)| 紀錄個數(number of Record)|
| 主鍵(Primary Key| 唯一識別(unique identifier)|
| 定義域(Domain)| 合法值群(pool legal values)|

e.g.
| 學號| 姓名| 系碼|
|---|---|---|
| b1| Jim| m1|
| b2| Ian| m2|
| b3| Tom| m1|

學號，姓名以及系碼為三個屬性名稱，各欄位下的數值為屬性質。
此外，學號就是主鍵(Primary Key)，其下面的{ b1, b2, b3}就是值組
