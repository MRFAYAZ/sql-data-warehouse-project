--DESCRIPTION:
-- This SQL script is the foundational initialization file for a modern Data Warehouse project
-- following the Medallion Architecture pattern (Bronze, Silver, Gold layers).
-- It creates the main DataWarehouse database and organizes it into three distinct schemas
-- that represent different stages of data transformation and quality.
--
-- DATA WAREHOUSE ARCHITECTURE:
-- The implementation follows the Medallion Architecture (also known as Delta Lake Architecture):
--
-- 1. BRONZE SCHEMA (Raw Data Layer)
--    - Contains raw, unprocessed data extracted from source systems
--    - Minimal transformation
--    - Maintains data lineage and historical records
--    - Used for data ingestion and staging
--
-- 2. SILVER SCHEMA (Processed/Cleaned Data Layer)
--    - Contains cleaned, validated, and deduplicated data
--    - Applied business rules and data quality checks
--    - Intermediate transformation layer
--    - Optimized for analytics queries
--    - Acts as single source of truth (SSOT) for analytics
--
-- 3. GOLD SCHEMA (Business Intelligence Layer)
--    - Contains aggregated, business-ready data
--    - Dimension tables (slowly changing dimensions - SCD)
--    - Fact tables (conformed dimensions)
--    - Optimized for reporting and BI tools (Power BI, Tableau, etc.)
--    - Final layer for end-users and executives
--
-- DEPENDENCIES:
-- - SQL Server 2016 or higher
-- - Master database access (required for USE master statement)
-- - Database creation permissions
--
-- ASSUMPTIONS:
-- - Running on SQL Server (not MySQL, PostgreSQL, etc.)
-- - User has sufficient permissions to create databases and schemas
-- - No existing 'DataWarehouse' database (script will fail if it exists)
--
-- HOW TO RUN:
-- 1. Open SQL Server Management Studio (SSMS) or Azure Data Studio
-- 2. Connect to your SQL Server instance
-- 3. Open this script file (init_database.sql)
-- 4. Execute the entire script (Ctrl+Shift+E or click Execute)
-- 5. Verify: Check Object Explorer → Databases → DataWarehouse
--    and confirm three schemas are created (bronze, silver, gold)
--
-- EXECUTION TIME: < 1 second
-- ===============================================

-- Switch context to master database
-- Required to create a new database at the server level
USE master;

-- Create the main DataWarehouse database
-- This database will serve as the central repository for all data warehouse objects
-- The database uses default collation and recovery model
CREATE DATABASE DataWarehouse;

-- Switch context to the newly created DataWarehouse database
-- All subsequent objects (schemas, tables, etc.) will be created in this database
USE DataWarehouse;

-- Create BRONZE schema (Raw Data Ingestion Layer)
-- PURPOSE: Stores raw, unmodified data extracted from source systems
-- LAYER: Layer 1 - Data Ingestion
-- CHARACTERISTICS:
--   - No data transformation applied
--   - Maintains original data format from sources
--   - Used for initial data landing and staging
--   - Tables typically named with "_raw" suffix (e.g., customers_raw, orders_raw)
--   - Minimal indexing, used for ETL staging
CREATE SCHEMA bronze;
GO

-- Create SILVER schema (Cleaned & Validated Data Layer)
-- PURPOSE: Stores transformed, cleaned, and deduplicated data
-- LAYER: Layer 2 - Data Processing & Quality
-- CHARACTERISTICS:
--   - Data cleaned and validated
--   - Business rules applied
--   - Duplicates removed
--   - Acts as Single Source of Truth (SSOT)
--   - Used for intermediate analytics and data exploration
--   - Tables typically use business-friendly names (e.g., customers, orders)
CREATE SCHEMA silver;
GO

-- Create GOLD schema (Business Intelligence & Analytics Layer)
-- PURPOSE: Stores aggregated, business-ready data for reporting and BI tools
-- LAYER: Layer 3 - Analytics & Reporting
-- CHARACTERISTICS:
--   - Dimension tables (SCD Type 1, 2, or 3)
--   - Fact tables with conformed dimensions
--   - Fully optimized for queries and dashboards
--   - Used by Power BI, Tableau, SQL Server Reporting Services (SSRS)
--   - Tables typically follow star/snowflake schema patterns
--   - Heavy indexing for query performance
CREATE SCHEMA gold;
GO

-- TROUBLESHOOTING:
-- If script fails:
-- 1. Error: "Database 'DataWarehouse' already exists"
--    Solution: DROP DATABASE DataWarehouse; then re-run script
-- 2. Error: "CREATE DATABASE permission denied"
--    Solution: Check SQL Server login permissions (must be sysadmin)
-- 3. Error: "USE statement not allowed after USE in batch"
--    Solution: Execute script all at once (don't run line-by-line)
--
-- ===============================================

