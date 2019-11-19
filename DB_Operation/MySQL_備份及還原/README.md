# MySQL資料庫的備份相關
1. 備份mysqldump
```shell
# 拉出指定db下的指定表格
->$: mysqldump -uroot -psecret $dumped_database $dumped_table > mysqltable.sql

# or
# 拉出指定db下的指定表格，表格的某一欄位需要符合情境
->$: mysqldump -uroot -psecret $dumped_database $dumped_table --where="created_time < '2019-10-01 00:00:00'" > mysqltable.sql
```

2. 還原dump出來的sql到其他DB
```shell
->$: mysqldump -uroot -psecret $dumped_database $dumped_table < mysqltable.sql
```

3. 驗證確認備份成功
```sql
SELECT * FROM $dumped_database.$dumped_table WHERE created_time < '2019-10-01 00:00:00';
```

4. 刪除msyql指定表的資料
```sql
mysql> DELETE FROM $dumped_database.$dumped_table WHERE created_at < '2019-10-01 00:00:00';
```

5. 確認刪除後record數有確實減少
```sql
SELECT * FROM $dumped_database.$dumped_table WHERE created_time < '2019-10-01 00:00:00';
```

# refer:
簡易dump及restore資料庫資料
- https://phoenixnap.com/kb/how-to-backup-restore-a-mysql-database

使用`condition`拉出指定情境下的資料
- https://idiallo.com/blog/mysql-dump-table-where
 
依據資料庫時間點進行資料還原
- https://dev.mysql.com/doc/mysql-backup-excerpt/5.5/en/point-in-time-recovery-times.html

```shell
->: mysqldump -uroot -psecret $dumped_database $dumped_table1 $dumped_table2 $dumped_tabl3 --where="created_time < '2019-10-01 00:00:00'" > mysqltable.sql
```
一次dump多個mysql的資料表
- https://dba.stackexchange.com/questions/9306/how-do-you-mysqldump-specific-tables