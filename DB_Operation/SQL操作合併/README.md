# 常用的SQL指令
1. 使用UNION將兩句SQL指令串接起來;(備註:UNION要大寫)
> SELECT OrderID FROM Orders UNION select OrderID from OrderDetails;
2. UNION ALL，不篩選掉重複資料。將所有SQL指令的結果全部顯示出來。
> SELECT OrderID FROM Orders UNION ALL select OrderID from OrderDetails;
3. [sql-case]: 用case來做sql-script。
```
select case("col_name")
when "criterion1" then "result1"
when "criterion2" then "result2"
...
else "result_else"
end
from "table_name";
```



# 關於一些名詞解釋的差異`PRIMARY KEY`&`UNIQUE KEY`&`KEY`
- Meaning of "PRIMARY KEY","UNIQUE KEY" and "KEY" when used together while creating a table
example as below;
```sql
REATE TABLE IF NOT EXISTS `tmp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `tag` int(1) NOT NULL DEFAULT '0',
  `description` varchar(255),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `name` (`name`),
  KEY `tag` (`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=1 ;
```

1. key: 一般的索引，就像書籤一樣
2. unique_key: 用來增加索引速度，對於所有的unique_key來說，欄位下的所有值都是唯一的
3. primary_key: 特需情境下的`unique_key`，通常是用來表示該筆record的`Uuid`


# refer:
- https://stackoverflow.com/questions/10908561/mysql-meaning-of-primary-key-unique-key-and-key-when-used-together-whil