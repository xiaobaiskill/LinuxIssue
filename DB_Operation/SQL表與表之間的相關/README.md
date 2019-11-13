# 紀錄常用的SQL語法
1. delete from : 根據條件刪除表的部分值
> delete from OrderDetails as a where a.OrderDetailID in (1,2);
2. update : 修改表格中的某欄位的值; 備註：不能使用alias -- (X) update OrderDetails as a set a.Quantity=100 where a.Quantity=5;
> update OrderDetails set Quantity=100 where Quantity=5;
3. Alter table : 新增/更換/刪除 指令表格的'欄位'
> 新增表格欄位'Gender char(1)' alter table Orders ADD Gender char(1);
> 更換'Gender char(1)'資料型態 alter table Orders CHANGE Gender integer; -- 網頁版有問題無法正常執行
> 刪除指令欄位'Gender char(1)' alter drop Orders column Gender; -- 網頁版有問題無法正常執行
4. drop table : 直接刪除整張表格
> drop table Orders;
5. insert into : 將資料塞入表中，資料型態需要符合依照該表對應欄位的資料型態
> INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, ShipperID) VALUES (10247, 900, 100, 'Jan-10-1999', 999);
6. index : 