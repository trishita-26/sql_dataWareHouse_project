create or alter procedure silver.load_silver as
begin 

exec silver.load_silver

print '>> Truncating table: silver.crm_cust_info ';
Truncate table silver.crm_cust_info;
print '>>Inserting data Into: silver.crm_cust_info';
insert into silver.crm_cust_info(
      cst_id,
      cst_key,
      cst_firstname,
      cst_lastname,
      cst_material_status,
      cst_gndr,
      cst_create_date
)
select
cst_id,
cst_key,
TRIM (cst_firstname) as cst_firstname,
TRIM (cst_lastname) as cst_lastname,
case when upper(trim(cst_material_status)) = 'S' then 'Single'
     when upper(trim(cst_material_status)) = 'M' then 'Married'
     else 'n/a'
end cst_material_status,
case when upper(trim(cst_gndr)) = 'F' then 'Female'
     when upper(trim(cst_gndr)) = 'M' then 'Male'
     else 'n/a'
end cst_gndr,
cst_create_date
from (
     select 
     *,
     row_number() over (partition by cst_id order by cst_create_date desc) as flag_last
     from bronze.crm_cust_info
     where cst_id is not null
)t where flag_last = 1


-----------------------------------------------------
print '>> Truncating table: silver.crm_prd_info';
Truncate table silver.crm_prd_info;
print '>>Inserting data Into: silver.crm_prd_info';

INSERT INTO silver.crm_prd_info (
    prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)
SELECT 
    prd_id,
    REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
    SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,
    prd_nm,
    ISNULL(prd_cost, 0) AS prd_cost,
    CASE 
        WHEN UPPER(LTRIM(RTRIM(prd_line))) = 'M' THEN 'Mountain'
        WHEN UPPER(LTRIM(RTRIM(prd_line))) = 'R' THEN 'Road'
        WHEN UPPER(LTRIM(RTRIM(prd_line))) = 'S' THEN 'Other Sales'
        WHEN UPPER(LTRIM(RTRIM(prd_line))) = 'T' THEN 'Touring'
        ELSE 'N/A'
    END AS prd_line,
    CAST(prd_start_dt AS DATE) AS prd_start_dt,
    CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS DATE) AS prd_end_dt
FROM bronze.crm_prd_info;

----------------------------------------------------------------
/*
DDL structure

if OBJECT_ID ('silver.crm_sales_details')is not null
   drop table silver.crm_sales_details;
create table silver.crm_sales_details(
    sls_ord_num nvarchar(50),
    sls_prd_key nvarchar(50),
    sls_cust_id int,
    sls_order_dt date,
    sls_ship_dt date,
    sls_due_dt date,
    sls_sales int,
    sls_quantity int,
    sls_price int,
    dwh_create_date Datetime2 default getdate()
); */

print '>> Truncating table: silver.crm_sales_details';
Truncate table silver.crm_sales_details;
print '>>Inserting data Into: silver.crm_sales_details';
insert into silver.crm_sales_details(
         sls_ord_num,
         sls_prd_key,
         sls_cust_id,
         sls_order_dt,
         sls_ship_dt,
         sls_due_dt,
         sls_sales,
         sls_quantity,
         sls_price
)
select 
sls_ord_num,
sls_prd_key,
sls_cust_id,
case when sls_order_dt =0 or len(sls_order_dt) != 8 then null
     else CAST(cast(sls_order_dt as varchar(8)) as date)
end as sls_order_dt,

case when sls_ship_dt =0 or len(sls_ship_dt) != 8 then null
     else CAST(cast(sls_ship_dt as varchar(8)) as date)
end as sls_ship_dt,

case when sls_due_dt =0 or len(sls_due_dt) != 8 then null
     else CAST(cast(sls_due_dt as varchar(8)) as date)
end as sls_due_dt,

case when sls_sales is null or sls_sales <=0 or sls_sales != sls_quantity * abs(sls_price)
          then sls_quantity * abs(sls_price)
          else sls_sales
end as sls_sales,

sls_quantity,

case when sls_price is null or sls_price <=0
         then sls_sales/  nullif(sls_quantity,0)
     else sls_price
end as sls_price

from bronze.crm_sales_details

------------------------------------------------------------
print '>> Truncating table: silver.erp_cust_az12 ';
Truncate table silver.erp_cust_az12;
print '>>Inserting data Into: silver.erp_cust_az12';
insert into silver.erp_cust_az12(cid,bdate,gen)
select
case when cid Like 'NAS%' then SUBSTRING(cid, 4, len(cid))
     else cid
end as cid,

case when bdate > getdate() then null
     else bdate
end as bdate,

case when upper(trim(gen)) in ('F','Female') then 'Female'
     when upper(trim(gen)) in ('M','Male') then 'Male'
     else 'n/a'
end as gen

from bronze.erp_cust_az12
--------------------------------------------------------------------

print '>> Truncating table: silver.erp_cust_az12 ';
Truncate table silver.erp_cust_az12;
print '>>Inserting data Into: silver.erp_cust_az12';
insert into silver.erp_loc_a101(cid,cntry)
select
replace(cid, '-', '') cid,
case when trim(cntry) = 'DE' then 'Germany'
     when trim(cntry) in ('US' , 'USA') then 'United States'
     when trim(cntry) = '' or cntry is null then 'n/a'
     else trim(cntry) 
end as cntry
from bronze.erp_loc_a101
-----------------------------------------------------------------
print '>> Truncating table: silver.erp_px_cat_g1v2 ';
Truncate table silver.erp_px_cat_g1v2;
print '>>Inserting data Into: silver.erp_px_cat_g1v2';
insert into silver.erp_px_cat_g1v2
(
id,
cat,
subcat,
maintenance
)
select
id,
cat,
subcat,
maintenance
from bronze.erp_px_cat_g1v2
end
