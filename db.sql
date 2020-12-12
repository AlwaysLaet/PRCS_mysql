CREATE DATABASE IF NOT EXISTS purchase_records;

USE purchase_records;

CREATE TABLE purchases( DATE DATETIME, CUST_ID INT, PROD_ID INT );

CREATE TABLE customers( CUST INT, STATE CHAR(2), POSTAL INT );

CREATE TABLE products( PROD INT, 2018_Q1 DOUBLE, 2018_Q2 DOUBLE, 2018_Q3 DOUBLE, 2018_Q4 DOUBLE, 2019_Q1 DOUBLE, 2019_Q2 DOUBLE, 2019_Q3 DOUBLE, 2019_Q4 DOUBLE);

LOAD DATA LOCAL INFILE '/csv_link/purchases.csv' INTO TABLE purchases FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/csv_link/customers.csv' INTO TABLE customers FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;
UPDATE customers SET STATE=NULL, POSTAL=NULL WHERE STATE="NA";

LOAD DATA LOCAL INFILE '/csv_link/products.csv' INTO TABLE products FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;
