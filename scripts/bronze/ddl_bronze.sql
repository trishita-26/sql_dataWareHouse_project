/*

Stored Procedure: Load Bronze Layer (Source -> Bronze)
Script Purpose:
     This stored procedure loads data into the 'bronze' schema from external CSV files.
     It performs the following actions:
     - Truncates the bronze tables before loading data.

Uses the BULK INSERT command to load data from csv Files to bronze tables.

Parameters: None..
This stored procedure does not accept any parameters or return any values.

Usage Example: EXEC bronze.load_bronze;
*/
if OBJECT_ID ('bronze.crm_cust_info')is not null
   drop table bronze.crm_cust_info;
create table bronze.crm_cust_info(
cst_id INT,
cst_key NVARCHAR(50),
cst_firstname nvarchar(50),
cst_lastname nvarchar(50),
cst_material_status nvarchar(50),
cst_gndr nvarchar(50),
cst_create_date DATE
);
if OBJECT_ID ('bronze.crm_prd_info')is not null
   drop table bronze.crm_prd_info;
create table bronze.crm_prd_info(
   prd_id  int,
   prd_key nvarchar(50),
   prd_nm nvarchar(50),
   prd_cost int,
   prd_line nvarchar(50),
   prd_start_dt datetime,
   prd_end_dt Datetime
);
if OBJECT_ID ('bronze.crm_sales_details')is not null
   drop table bronze.crm_sales_details;
create table bronze.crm_sales_details(
    sls_ord_num nvarchar(50),
    sls_prd_key nvarchar(50),
    sls_cust_id int,
    sls_order_dt int,
    sls_ship_dt int,
    sls_due_dt int,
    sls_sales int,
    sls_quantity int,
    sls_price int
);
if OBJECT_ID ('bronze.erp_loc_a101')is not null
   drop table bronze.erp_loc_a101 ;
create table bronze.erp_loc_a101 (
    cid  nvarchar(50),
    cntry nvarchar(50)
);
if OBJECT_ID ('bronze.erp_cust_az12')is not null
   drop table bronze.erp_cust_az12;
create table bronze.erp_cust_az12(
  cid nvarchar(50),
  bdate date,
  gen nvarchar(50)
);
if OBJECT_ID ('bronze.erp_px_cat_g1v2')is not null
   drop table bronze.erp_px_cat_g1v2;
create table bronze.erp_px_cat_g1v2(
   id  nvarchar(50),
   cat  nvarchar(50),
   subcat  nvarchar(50),
   maintenance  nvarchar(50),
);

