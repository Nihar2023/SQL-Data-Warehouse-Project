/*
================================================================================
SUMMARY: BRONZE LAYER DATA LOAD PROCEDURE
================================================================================

Purpose:
- This procedure loads raw data from CSV files into the Bronze Layer.
- Before loading, existing data is removed using TRUNCATE TABLE.
- BULK INSERT loads the CSV data into the Bronze tables.
- Load duration is calculated for each table.
- TRY...CATCH handles errors during the loading process.
- Batch start/end time is used to calculate the total loading duration.

Flow:
    CSV Files
        ↓
    TRUNCATE Bronze Tables
        ↓
    BULK INSERT
        ↓
    Bronze Layer Tables

Sources:
    CRM → Customer, Product, Sales
    ERP → Customer, Location, Product Category

================================================================================
*/


-- Create or modify the stored procedure used to load
-- all raw source data into the Bronze Layer.
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN

	-- Variables used to track individual table load time
	-- and the total batch loading time.
	DECLARE @start_time DATETIME, 
			@end_time DATETIME, 
			@batch_start_time DATETIME, 
			@batch_end_time DATETIME;


	BEGIN TRY

		-- Record the time when the complete Bronze loading process starts.
		SET @batch_start_time = GETDATE()


		-- ============================================================
		-- START BRONZE LAYER LOADING
		-- ============================================================

		PRINT '=====================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=====================================';


		-- ============================================================
		-- CRM TABLES
		-- Load raw data from CRM CSV files into Bronze tables.
		-- ============================================================

		PRINT '-------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '--------------------------------------';


		-- ------------------------------------------------------------
		-- 1. Load CRM Customer Information
		-- ------------------------------------------------------------

		-- Remove existing data before loading the latest CSV data.
		PRINT '>>Truncating Table: broze.crm_cust_info';
		PRINT '>>Inserting Data Into: bronze.crm_cust_info';

		TRUNCATE TABLE bronze.crm_cust_info;

		-- Start timer for this table.
		SET @start_time = GETDATE();

		-- Load customer data from CSV into the Bronze table.
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\Skills\SQL Datawarehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,              -- Skip CSV header
			FIELDTERMINATOR = ',',     -- CSV columns separated by comma
			TABLOCK                    -- Use table-level lock for faster loading
		);

		-- End timer and display loading duration.
		SET @end_time = GETDATE();

		PRINT 'Load Duration: '+
			  CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+
			  'seconds';


		-- ------------------------------------------------------------
		-- 2. Load CRM Product Information
		-- ------------------------------------------------------------

		PRINT '>>Truncating Table: broze.crm_prd_info';
		PRINT '>>Inserting Data Into: bronze.crm_prd_info';

		TRUNCATE TABLE bronze.crm_prd_info;

		SET @start_time = GETDATE();

		BULK INSERT bronze.crm_prd_info
		FROM 'D:\Skills\SQL Datawarehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();

		PRINT 'Load Duration: '+
			  CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+
			  'seconds';


		-- ------------------------------------------------------------
		-- 3. Load CRM Sales Information
		-- ------------------------------------------------------------

		PRINT '>>Truncating Table: broze.crm_sales_details';
		PRINT '>>Inserting Data Into: bronze.crm_sales_details';

		TRUNCATE TABLE bronze.crm_sales_details;

		SET @start_time = GETDATE();

		BULK INSERT bronze.crm_sales_details
		FROM 'D:\Skills\SQL Datawarehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();

		PRINT 'Load Duration: '+
			  CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+
			  'seconds';


		-- ============================================================
		-- ERP TABLES
		-- Load raw data from ERP CSV files into Bronze tables.
		-- ============================================================

		PRINT '-------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '--------------------------------------';


		-- ------------------------------------------------------------
		-- 4. Load ERP Customer Information
		-- ------------------------------------------------------------

		PRINT '>>Truncating Table: broze.erp_cust_az12';
		PRINT '>>Inserting Data Into: bronze.erp_cust_az12';

		TRUNCATE TABLE bronze.erp_cust_az12;

		SET @start_time = GETDATE();

		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\Skills\SQL Datawarehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();

		PRINT 'Load Duration: '+
			  CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+
			  'seconds';


		-- ------------------------------------------------------------
		-- 5. Load ERP Location Information
		-- ------------------------------------------------------------

		PRINT '>>Truncating Table: broze.erp_loc_a101';
		PRINT '>>Inserting Data Into: bronze.erp_loc_a101';

		TRUNCATE TABLE bronze.erp_loc_a101;

		SET @start_time = GETDATE();

		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\Skills\SQL Datawarehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();

		PRINT 'Load Duration: '+
			  CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+
			  'seconds';


		-- ------------------------------------------------------------
		-- 6. Load ERP Product Category Information
		-- ------------------------------------------------------------

		PRINT '>>Truncating Table: broze.erp_px_cat_g1v2';
		PRINT '>>Inserting Data Into: bronze.erp_px_cat_g1v2';

		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		SET @start_time = GETDATE();

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\Skills\SQL Datawarehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();

		PRINT 'Load Duration: '+
			  CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+
			  'seconds';


		-- ============================================================
		-- BRONZE LAYER LOADING COMPLETED
		-- ============================================================

		-- Record the time when the complete loading process finishes.
		SET @batch_end_time = GETDATE();


		-- Display total loading time for all Bronze tables.
		PRINT '---------------------------------------------------------------';
		PRINT 'Loading Bronze Layer is Completed';

		PRINT 'Total Duration: '+
			  CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR)+
			  'seconds';

		PRINT '---------------------------------------------------------------';


	-- ============================================================
	-- ERROR HANDLING
	-- If any error occurs during loading, execution comes here.
	-- ============================================================

	END TRY

	BEGIN CATCH

		PRINT '==========================================================';
		PRINT 'ERROR OCCURED DURING LOADING DATA INTO BRONZE LAYER';

		-- Display the actual error message.
		PRINT 'ERROR MESSAGE'+ ERROR_MESSAGE();

		-- Display the SQL Server error number.
		PRINT 'ERROR MESSAGE'+ 
			  CAST(ERROR_NUMBER() AS NVARCHAR);

		-- Display the error state.
		PRINT 'ERROR MESSAGE'+ 
			  CAST(ERROR_STATE() AS NVARCHAR);

		PRINT '==========================================================';

	END CATCH 

END
