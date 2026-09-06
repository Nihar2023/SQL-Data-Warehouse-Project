-- =============================================
-- DATABASE INITIALIZATION
-- =============================================
-- If DataWarehouse already exists, delete it.
-- Then create a fresh DataWarehouse database.
-- Finally, create Bronze, Silver, and Gold schemas.
-- =============================================


-- Switch to the master database
USE master;
GO


-- Delete DataWarehouse if it already exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    DROP DATABASE DataWarehouse;
END
GO


-- Create a fresh DataWarehouse database
CREATE DATABASE DataWarehouse;
GO


-- Switch to the DataWarehouse database
USE DataWarehouse;
GO


-- Create Bronze schema for raw data
CREATE SCHEMA bronze;
GO


-- Create Silver schema for cleaned/transformed data
CREATE SCHEMA silver;
GO


-- Create Gold schema for final/business-ready data
CREATE SCHEMA gold;
GO
