/*


========================================================================================
Create Database and Schemas
========================================================================================
Script Purpose :
  This script creates a new database named 'DataWareHouse' after checking if it already exists or not.
  if the database exist, it is dropped or recreated. Additionally the scripts sets up three schemas 
  within the database : 'bronze', 'silver' and 'gold'

WARNING:
  Running this script will drop the entire 'DataWareHouse' database if it exists.
  All the data within the database permanently deleted. proceed with caution
  and ensure you have proper backups before running the script.
*/

use master ;
go

-- Drop and recreate the database if exists named 'DataWarehouse'
if exists ( select 1 from sys.databases where name = 'DataWareHouse')
begin 
  alter database DataWareHouse set single_user with rollback immediate;
  drop database DataWareHouse;
end;

-- Creating Database

create database DataWareHouse

use DataWareHouse
go
create schema bronze;
go
create schema silver;
go
create schema gold;
go
