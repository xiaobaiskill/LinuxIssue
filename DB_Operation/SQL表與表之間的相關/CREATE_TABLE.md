# sql常用的create table指令
1. create table : 在某個database下創建新的表格，以及定義該表格下需要的欄位資料型態。
    - create table "表格名" ( "欄位1" “欄位1資料型別", "欄位2" “欄位2資料型別", "欄位3" “欄位3資料型別" ... )
> create table JimTable (first_col char(50), second_col char(25)); 
2. create view : 鑑於某個表格創建一個view方便觀察及管控表。註:此處的as不是alias的as。
    - crate view "視觀表名稱" as {{ SQL-select 語法 }} from {{ TableName }}
> create view V_Shippers as select * from Shippers;
3. 創造含有primary key的table
    - create table "要創造的表格名稱" ( "欄位1名稱" "欄位1資料型態", "欄位2名稱" "欄位2資料型態", "欄位3名稱" "欄位3資料型態", ..., primary key("要成為pk的欄位") )
> create table testPk ( id integer, last_name varchar(30), first_name varchar(30), primary key(id) );
4. 創造含有foreign key的table
    - 1. 前置條件需要具備一個可以被refer的table
    - 2. create table "要創造的表格名稱" ( "欄位1名稱" "欄位1資料型態", "欄位2名稱" "欄位2資料型態", "欄位3名稱" "欄位3資料型態", ..., references "要參照的table"("參照的欄位") )
> create table customer(id integer primary key);
> create table test (id integer primary key, date timestamp, cust_id integer references customer(id), amount integer);

- 備註：改變現在既有的primary key表格架構
> alter table testPk add primary key(last_name) -- 網頁版有問題無法正常執行