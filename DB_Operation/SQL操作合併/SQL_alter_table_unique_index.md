# sql
## Create
### create an column under specific table: 在一個既有的表格增加一個欄位
```sql
ALTER TABLE jimdatabase.jimtablename
ADD COLUMN columnName VARCHAR(8);

-- VARCHAR可以換為其他的資料格式，8也只是代表一個數字
```

### create an unique_index: 只能針對既有存在的TABLE做增加
```sql
ALTER TABLE jimdatabase.jimtablename
ADD UNIQUE INDEX IndexName(indexColumn1, indexColumn2, indexColumn3);

-- IndexName 為查詢時，期望看到的名稱
-- indexColumn 為期望組合作unique key的index
```

## Delete
### drop an column under specific table: 刪除一個既有存在的欄位
```sql
ALTER TABLE jimdatabase.jimtablename
DROP COLUMN columnName;
```

### drop an unique_index: 將一個 index 刪除
```sql
ALTER TABLE jimdatabase.jimtablename
DROP INDEX index_columnName;
```


### quick command
```sql
ALTER TABLE ruokdraw_load.lottery_prev_status
-- ADD COLUMN test VARCHAR(8);
-- ADD UNIQUE (test);
-- DROP COLUMN test;
```

### alter existing unique constraint: 將一個既有的unique index做更新
1. Step 1: Drop old constraint:
```sql
ALTER TABLE `Message` DROP INDEX `user_id`;
```

2. Step 2: Add new:
```sql
ALTER TABLE `Message` ADD UNIQUE INDEX (
         `user_id`, 
         `user_to`, 
         `top_num`, 
         `msg_type`);
```

Almost the same as alter foreign key ...

# refer:
- https://stackoverflow.com/questions/5038040/mysql-make-an-existing-field-unique
- https://stackoverflow.com/questions/21777787/altering-existing-unique-constraint