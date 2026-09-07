USE DataWarehouse;

-- ============================================================
-- BRONZE LAYER TABLE CREATION
-- Purpose:
-- 1. Select the DataWarehouse database.
-- 2. Check if each Bronze table already exists.
-- 3. Drop the old table if it exists.
-- 4. Create a fresh table with the required columns/data types.
-- 5. These Bronze tables will store raw data loaded from source files.
-- ============================================================


-- ------------------------------------------------------------
-- 1. CRM CUSTOMER INFORMATION
-- Drops the existing customer table and creates a new one
-- to store raw customer information from the CRM source.
-- ------------------------------------------------------------

IF OBJECT_ID ('bronze.crm_cust_info','U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;

CREATE TABLE bronze.crm_cust_info(
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE
);


-- ------------------------------------------------------------
-- 2. CRM PRODUCT INFORMATION
-- Drops the existing product table and creates a new one
-- to store raw product information from the CRM source.
-- ------------------------------------------------------------

IF OBJECT_ID ('bronze.crm_prd_info','U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info(
	prd_id INT,
	pry_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATETIME,
	prd_end_dt DATETIME
);


-- ------------------------------------------------------------
-- 3. CRM SALES INFORMATION
-- Drops the existing sales table and creates a new one
-- to store raw sales/transaction information from the CRM source.
-- ------------------------------------------------------------

IF OBJECT_ID ('bronze.crm_sales_details','U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
);


-- ------------------------------------------------------------
-- 4. ERP LOCATION INFORMATION
-- Drops the existing location table and creates a new one
-- to store customer country/location information from ERP.
-- ------------------------------------------------------------

IF OBJECT_ID ('bronze.erp_loc_a101','U') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;

CREATE TABLE bronze.erp_loc_a101(
	cid NVARCHAR(50),
	cntry NVARCHAR(50)
);


-- ------------------------------------------------------------
-- 5. ERP CUSTOMER INFORMATION
-- Drops the existing ERP customer table and creates a new one
-- to store customer birth date and gender information.
-- ------------------------------------------------------------

IF OBJECT_ID ('bronze.erp_cust_az12','U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;

CREATE TABLE bronze.erp_cust_az12(
	cid NVARCHAR(50),
	bdate DATE,
	gen NVARCHAR(50)
);


-- ------------------------------------------------------------
-- 6. ERP PRODUCT CATEGORY INFORMATION
-- Drops the existing category table and creates a new one
-- to store product category, subcategory, and maintenance data.
-- ------------------------------------------------------------

IF OBJECT_ID ('bronze.erp_px_cat_g1v2','U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;

CREATE TABLE bronze.erp_px_cat_g1v2(
	id NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50)
);
