/* 
================================================================================================
Stored Procedure : load Bronze Layer ( Source -> Bronze)
================================================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It perfoms the following actions :
    - Truncates the bronze tables before loading data.
    - Uses the 'BULK INSERT' command to load data from csv files to bronze tables.

Parameters :
    None.
    This stored procedure does not accept any parameters or return any values.

Using Example:
  Exec bronze.load_bronze;
===============================================================================================
*/

create or alter procedure bronze.load_bronze as
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
	begin try
		print '=============================================';
		print 'Loading Bronze Layer';
		print '=============================================';
	
		print '---------------------------------------------';
		print 'Loading CRM Tables';
		print '----------------------------------------------';
	
-- 1. Table name : Bronze.crm_cust_info	
		set @start_time = getdate()
		print '>>> Truncating table : bronze.crm_cust_info'
		truncate table bronze.crm_cust_info;
		print '>> Inserting data into : bronze.crm_cust_info'
		bulk insert bronze.crm_cust_info
		from 'D:\my personal things\Ultimate SQL\SQL Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE()
		print '>>> Load Duration : '+ cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '---------------------------------------'


		-- 2. Table name : Bronze.crm_prd_info
		set @start_time = getdate()
		print '>>> Truncating table : bronze.crm_prd_info'
		truncate table bronze.crm_prd_info;
		print '>> Inserting data into : bronze.crm_prd_info'
		bulk insert bronze.crm_prd_info
		from 'D:\my personal things\Ultimate SQL\SQL Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE()
		print '>>> Load Duration :' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '---------------------------------------'


		-- 3 Table name : Bronze.crm_sales_details
		set @start_time = getdate()
		print '>>> Truncating table : bronze.crm_sales_details'
		truncate table bronze.crm_sales_details;
		print '>> Inserting data into :  bronze.crm_sales_details'
		bulk insert bronze.crm_sales_details
		from 'D:\my personal things\Ultimate SQL\SQL Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		print '>>> Load Duration : '+ cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '---------------------------------------'

		print '---------------------------------------------';
		print 'Loading ERP Tables';
		print '----------------------------------------------';




		-- 4 Table name : bronze.erp_cust_az12
		set @start_time = getdate()
		print '>>> Truncating table :bronze.erp_cust_az12 '
		truncate table bronze.erp_cust_az12;
		print '>> Inserting data into :  bronze.erp_cust_az12 '
		bulk insert bronze.erp_cust_az12
		from 'D:\my personal things\Ultimate SQL\SQL Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv' 
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		print '>>> Load Duration : '+ cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '---------------------------------------'
		
		-- 5 Table name : bronze.erp_loc_a101
		set @start_time = getdate()
		print '>>> Truncating table : bronze.erp_loc_a101'
		truncate table bronze.erp_loc_a101;
		print '>> Inserting data into : bronze.erp_loc_a101 '
		bulk insert bronze.erp_loc_a101
		from 'D:\my personal things\Ultimate SQL\SQL Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv' 
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		print '>>> Load Duration : '+ cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '---------------------------------------'
		
		-- 6 Table name : bronze.erp_px_cat_g1v2
		set @start_time = getdate()
		print '>>> Truncating table : bronze.erp_px_cat_g1v2'
		truncate table bronze.erp_px_cat_g1v2;
		print '>> Inserting data into :  bronze.erp_px_cat_g1v2 '
		bulk insert bronze.erp_px_cat_g1v2
		from 'D:\my personal things\Ultimate SQL\SQL Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		print '>>> Load Duration : '+ cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '---------------------------------------'


		set @batch_end_time = getdate();
		print '======================================'
		print 'Loading Bronze Layer is Completed';
		print 'Total Load Duration: ' + cast(datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + 'seconds';
		
	end try
	begin catch
		print '============================================'
		print 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		print 'Error Message' + Error_message();
		print 'Error Message' + cast(error_number() as nvarchar);
		print 'Error Message' + cast(error_state() as nvarchar);
		print '============================================='
	end catch
end ;
-- execute the store procedure
exec bronze.load_bronze
