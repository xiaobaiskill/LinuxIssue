# 情境
Suppose, a table1 has a foreign key with column name fk_table2_id, with constraint name fk_name and table2 is referred table with key t2 (something like below in my diagram).
```
  table1 [ fk_table2_id ] --> table2 [t2]
```

### First step, DROP old CONSTRAINT: (reference)
```sql
ALTER TABLE `table1` 
DROP FOREIGN KEY `fk_name`;
```

### Second step, ADD new CONSTRAINT:
```sql
ALTER TABLE `table1`  
ADD CONSTRAINT `fk_name` 
    FOREIGN KEY (`fk_table2_id`) REFERENCES `table2` (`t2`) ON DELETE CASCADE;
```

# refer:
- https://stackoverflow.com/questions/3359329/how-to-change-the-foreign-key-referential-action-behavior?lq=1