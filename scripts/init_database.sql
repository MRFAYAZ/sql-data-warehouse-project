-- ===============================================
-- FILE: init_database.sql
-- PROJECT: Data Warehouse  
-- LAYER: Initialization
-- PURPOSE: Create raw staging tables  
-- ===============================================

/*
#Prerequisites 
- SQL Server 2016+ 
- Master database access
- Database creation permissions

#Setup Steps:
1. Open SSMS/Azure Data Studio
2. Connect to SQL Server instance
3. Execute entire script (Ctrl+Shift+E)

#Execution: < 1 second
*/

-- Switch context to master database
USE master;
GO

-- Drop if exists (idempotent)
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Create main DataWarehouse database
CREATE DATABASE DataWarehouse;
GO

-- Switch to DataWarehouse context
USE DataWarehouse;
GO

-- BRONZE: Raw data layer
CREATE SCHEMA bronze;
GO

-- SILVER: Cleaned data layer
CREATE SCHEMA silver;
GO

-- GOLD: BI ready layer
CREATE SCHEMA gold;
GO

/*
#Expected Output:
✓ DataWarehouse database created
✓ bronze, silver, gold schemas created

#Troubleshooting:
| Error | Solution |
|-------|----------|
| Permission denied | Grant sysadmin role |
| Database exists | Script auto-drops |
| Batch error | Execute all at once |
*/
