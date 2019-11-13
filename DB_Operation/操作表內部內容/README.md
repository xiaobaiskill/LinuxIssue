# 紀錄常用的SQL語法
1. replace : 以值取代表內某欄的值。
> select replace (ProductName, 'Chais', 'Jim') from Products;
2. join(概念) : 通常用於宣稱alias後把兩張表以結合的形式做呈現
> select * from OrderDetails as a1, Orders as a2 where a1.OrderID = a2.OrderID;
3. group by : 同類分群;可以額外多加上計算，像是sum/average/
> SELECT OrderID,sum(Quantity) FROM OrderDetails group by OrderID;
4. having : 類似shell的'|'，通常是在對於sql執行的結果做進一步判斷用。
> SELECT OrderID,sum(Quantity) FROM OrderDetails group by OrderID having sum(Quantity) > 100;