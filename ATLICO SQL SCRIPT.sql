-- ------------------------------------------------------ DATABASE CREATION -------------------------------------------------------------------------
CREATE DATABASE plans;
USE plans;
-- ------------------------------------------------------ TABLES CREATION ---------------------------------------------------------------------------
#PLAN TABLE
CREATE TABLE plan(
    plan_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	plan_date VARCHAR(10) NOT NULL,
	city_code INT NOT NULL,
    plans VARCHAR(10),
	plan_revenue_crores FLOAT NOT NULL,
	city VARCHAR(50) NOT NULL,
	month VARCHAR(50) NOT NULL,
	gen varchar(50) NOT NULL,
	description varchar(100) NOT NULL,
KEY idx_fk_city_code(city_code),
KEY idx_fk_city(city)
);

#USERS_ACTIVENESS TABLE
CREATE TABLE users_activeness(
	id  INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	date VARCHAR(10) NOT NULL,
	month VARCHAR(10) NOT NULL,
	gen varchar(50) NOT NULL,
	city_code INT NOT NULL,
	city VARCHAR(50) NOT NULL,
	company VARCHAR(50) NOT NULL,
	atlico_revenue_crores VARCHAR(10) NOT NULL,
	arpu VARCHAR(10) NOT NULL,
	active_users_lakhs INT NOT NULL,
	unsubscribed_user_lakhs INT NOT NULL,
	time_period INT NOT NULL,
KEY idx_fk_city_code(city_code),
KEY idx_fk_city(city)
);

#BEFORE_VS_AFTER 5G TABLE
CREATE TABLE before_vs_after_5g(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	date VARCHAR(50) NOT NULL,
	city_code INT NOT NULL,
	tmv_city_crores VARCHAR(50) NOT NULL,
	company VARCHAR(50) NOT NULL,
	ms_pct VARCHAR(50) NOT NULL,
	month VARCHAR(10) NOT NULL,
    city VARCHAR(50),
	gen varchar(50) NOT NULL,
KEY idx_fk_city_code(city_code),
KEY idx_fk_city(city)
);

# IMPORT THE VALUES THROUGH TABLE IMPORT WIZARD
SELECT * FROM plans.before_vs_after_5g;
SELECT * FROM plans.plan;
SELECT * FROM plans.users_activeness;
SELECT DISTINCT city_code FROM before_vs_after_5g;
SELECT DISTINCT city FROM before_vs_after_5g;

#CITY TABLE
CREATE TABLE city (
city_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
city_code INT NOT NULL,
city_name VARCHAR(20) NOT NULL,
KEY idx_fk_name_code(city_code, city_name)
);
alter table city
add index idx_city_name(city_name);

-- ------------------------------------------------------- DATA CLEANING ------------------------------------------------------------------------------
#TABLE STANDARDIZATION
SELECT city_code,
       (CASE
            WHEN city_code = 110001 THEN 'Ahmedabad'
            WHEN city_code = 122001 THEN 'Bangalore'
            WHEN city_code = 160017 THEN 'Chandigarh' 
            WHEN city_code = 302001 THEN 'Chennai' 
            WHEN city_code = 380001 THEN 'Coimbatore' 
            WHEN city_code = 226001 THEN 'Delhi' 
            WHEN city_code = 400001 THEN 'Gurgaon' 
            WHEN city_code = 411001 THEN 'Hyderabad' 
            WHEN city_code = 492001 THEN 'Jaipur'
            WHEN city_code = 500001 THEN 'Kolkata' 
            WHEN city_code = 560001 THEN 'Lucknow' 
            WHEN city_code = 600001 THEN 'Mumbai' 
            WHEN city_code = 641001 THEN 'Patna' 
            WHEN city_code = 700001 THEN 'Pune'  
            WHEN city_code = 800008 THEN 'Raipur'
            ELSE 'NA'
       END) AS city_code_name
FROM plan
ORDER BY city_code;

ALTER TABLE before_vs_after_5g ADD COLUMN city_name VARCHAR(20);
SET SQL_SAFE_UPDATES = 0;
UPDATE before_vs_after_5g
SET city_name = (CASE
            WHEN city_code = 110001 THEN 'Ahmedabad'
            WHEN city_code = 122001 THEN 'Bangalore'
            WHEN city_code = 160017 THEN 'Chandigarh' 
            WHEN city_code = 302001 THEN 'Chennai' 
            WHEN city_code = 380001 THEN 'Coimbatore' 
            WHEN city_code = 226001 THEN 'Delhi' 
            WHEN city_code = 400001 THEN 'Gurgaon' 
            WHEN city_code = 411001 THEN 'Hyderabad' 
            WHEN city_code = 492001 THEN 'Jaipur'
            WHEN city_code = 500001 THEN 'Kolkata' 
            WHEN city_code = 560001 THEN 'Lucknow' 
            WHEN city_code = 600001 THEN 'Mumbai' 
            WHEN city_code = 641001 THEN 'Patna' 
            WHEN city_code = 700001 THEN 'Pune'  
            WHEN city_code = 800008 THEN 'Raipur'
            ELSE 'NA'
       END);

ALTER TABLE plan ADD COLUMN city_name VARCHAR(20);
UPDATE plan
SET city_code_name =  (CASE
            WHEN city_code = 110001 THEN 'Ahmedabad'
            WHEN city_code = 122001 THEN 'Bangalore'
            WHEN city_code = 160017 THEN 'Chandigarh' 
            WHEN city_code = 302001 THEN 'Chennai' 
            WHEN city_code = 380001 THEN 'Coimbatore' 
            WHEN city_code = 226001 THEN 'Delhi' 
            WHEN city_code = 400001 THEN 'Gurgaon' 
            WHEN city_code = 411001 THEN 'Hyderabad' 
            WHEN city_code = 492001 THEN 'Jaipur'
            WHEN city_code = 500001 THEN 'Kolkata' 
            WHEN city_code = 560001 THEN 'Lucknow' 
            WHEN city_code = 600001 THEN 'Mumbai' 
            WHEN city_code = 641001 THEN 'Patna' 
            WHEN city_code = 700001 THEN 'Pune'  
            WHEN city_code = 800008 THEN 'Raipur'
            ELSE 'NA'
       END);

SELECT DISTINCT city_code_name FROM plan;
SELECT * FROM plan;
ALTER TABLE plan DROP new_city_name;

ALTER TABLE users_activeness ADD COLUMN city_code_name VARCHAR(20);

UPDATE users_activeness
SET city_code_name =  (CASE
            WHEN city_code = 110001 THEN 'Ahmedabad'
            WHEN city_code = 122001 THEN 'Bangalore'
            WHEN city_code = 160017 THEN 'Chandigarh' 
            WHEN city_code = 302001 THEN 'Chennai' 
            WHEN city_code = 380001 THEN 'Coimbatore' 
            WHEN city_code = 226001 THEN 'Delhi' 
            WHEN city_code = 400001 THEN 'Gurgaon' 
            WHEN city_code = 411001 THEN 'Hyderabad' 
            WHEN city_code = 492001 THEN 'Jaipur'
            WHEN city_code = 500001 THEN 'Kolkata' 
            WHEN city_code = 560001 THEN 'Lucknow' 
            WHEN city_code = 600001 THEN 'Mumbai' 
            WHEN city_code = 641001 THEN 'Patna' 
            WHEN city_code = 700001 THEN 'Pune'  
            WHEN city_code = 800008 THEN 'Raipur'
            ELSE 'NA'
       END);
SELECT * FROM users_activeness;
ALTER TABLE users_activeness DROP city;

# DATE CONVERSION FROM STRING TO DATE
# CONVERSION OF THE before_vs_after_5g TABLE WITH COLUMN NAME Date FROM STRING TO DATE
ALTER TABLE before_vs_after_5g ADD COLUMN New_Date DATE;
UPDATE before_vs_after_5g
SET New_Date = STR_TO_DATE(`Date`, '%d-%m-%Y');
ALTER TABLE before_vs_after_5g DROP COLUMN `Date`;
ALTER TABLE before_vs_after_5g CHANGE COLUMN New_Date `Date` DATE;

# DATE CONVERSION FROM STRING TO DATE
# CONVERSION OF plan TABLE WITH COLUMN NAME Date FROM STRING TO DATE
ALTER TABLE plan ADD COLUMN New_Date DATE;
UPDATE plan
SET New_Date = STR_TO_DATE(plan_Date, '%d-%m-%Y');
ALTER TABLE plan DROP COLUMN plan_Date;
ALTER TABLE plan CHANGE COLUMN New_Date `Date` DATE;

# DATE CONVERSION FROM STRING TO DATE
# CONVERSION OF plan TABLE WITH COLUMN NAME Date FROM STRING TO DATE
ALTER TABLE users_activeness ADD COLUMN New_Date DATE;
UPDATE users_activeness
SET New_Date = STR_TO_DATE(`Date`, '%d-%b-%y');
ALTER TABLE users_activeness DROP COLUMN `Date`;
ALTER TABLE users_activeness CHANGE COLUMN New_Date `Date` DATE;

-- ----------------------------------------------------------------------------------
# DATA CONVERSION FROM STRING INTEGER
# CONVERSION OF before_vs_after_5g TABLE WITH COLUMN NAME Date FROM STRING TO DATE
ALTER TABLE before_vs_after_5g ADD COLUMN new_tmv_city_crores INT;
UPDATE before_vs_after_5g
SET new_tmv_city_crores = CAST(REPLACE(tmv_city_crores, '$', '') AS UNSIGNED);
ALTER TABLE before_vs_after_5g DROP COLUMN tmv_city_crores;
ALTER TABLE before_vs_after_5g CHANGE COLUMN new_tmv_city_crores tmv_city_crores INT;

# DATA CONVERSION FROM STRING INTEGER
# CONVERSION OF users_activeness TABLE, COLUMNS FROM STRING TO INTEGER
ALTER TABLE users_activeness ADD COLUMN new_atlico_revenue_crores INT;
UPDATE users_activeness
SET new_atlico_revenue_crores = CAST(REPLACE(atlico_revenue_crores, '$', '') AS UNSIGNED);
ALTER TABLE users_activeness DROP COLUMN atlico_revenue_crores;
ALTER TABLE users_activeness CHANGE COLUMN new_atlico_revenue_crores atlico_revenue_crores INT;

# DATA CONVERSION FROM STRING INTEGER
# CONVERSION OF users_activeness TABLE, COLUMNS FROM STRING TO INTEGER
ALTER TABLE users_activeness ADD COLUMN new_arpu INT;
UPDATE users_activeness
SET new_arpu = CAST(REPLACE(arpu, '$', '') AS UNSIGNED);
ALTER TABLE users_activeness DROP COLUMN arpu;
ALTER TABLE users_activeness CHANGE COLUMN new_arpu arpu INT;
-- --------------------------------------------------------------------------
# ADDING FOREIGN KEY
# BEFORE_VS_AFTER_5G TABLE
ALTER TABLE before_vs_after_5g 
ADD CONSTRAINT FK_before_vs_after_5g FOREIGN KEY (city_code) REFERENCES city(city_code) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE before_vs_after_5g 
ADD CONSTRAINT FK_city_name FOREIGN KEY (city) REFERENCES city(city_name) ON DELETE RESTRICT ON UPDATE CASCADE; 

# PLAN TABLE
ALTER TABLE plan 
ADD CONSTRAINT FK_plan1 FOREIGN KEY (city_code) REFERENCES city(city_code) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE plan 
ADD CONSTRAINT FK_plan2 FOREIGN KEY (city_code_name) REFERENCES city(city_name) ON DELETE RESTRICT ON UPDATE CASCADE; 

# USERS_ACTIVENESS TABLE
ALTER TABLE users_activeness 
ADD CONSTRAINT FK_users_activeness1 FOREIGN KEY (city_code) REFERENCES city(city_code) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE users_activeness 
ADD CONSTRAINT FK_users_activeness2 FOREIGN KEY (city_code_name) REFERENCES city(city_name) ON DELETE RESTRICT ON UPDATE CASCADE;

-- ---------------------------------------------- DATA AGGREGATION --------------------------------------------------------------------------------------
 CREATE VIEW v_ATLICO_data AS
 SELECT DISTINCT p.city_code, 
        p.plans, 
        p.plan_revenue_crores, 
        p.month, 
        p.gen, 
        p.description, 
        p.city_code_name, 
        p.Date,
		b.tmv_city_crores,
		ua.atlico_revenue_crores,
		ua.arpu
FROM plan p                  
left JOIN city c
	ON p.city_code = c.city_code
INNER JOIN users_activeness ua
	ON p.city_code = ua.city_code 
INNER JOIN before_vs_after_5g b 
	ON p.city_code = b.city_code;
    
SELECT * FROM v_ATLICO_data;

 

 
 














