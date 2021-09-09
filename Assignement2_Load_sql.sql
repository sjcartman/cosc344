DROP TABLE employee_experience;
DROP TABLE driving_time_log;
DROP TABLE driving_route_log;
DROP TABLE roster;
DROP TABLE employee cascade constraints;
DROP TABLE zone cascade constraints;
DROP TABLE zone_suburbs;
DROP TABLE stop cascade constraints;
DROP TABLE serviced_by;
DROP TABLE REGO;
DROP TABLE WOF;
DROP TABLE condition;
DROP TABLE bus;
DROP TABLE bus_make;
DROP TABLE ROUTE;

--Table:
CREATE TABLE employee
  (Employee_ID        INT PRIMARY KEY,
   lname      VARCHAR(15)      NOT NULL,
   fname      VARCHAR(15)      NOT NULL,
   Age_bracket INT,
   Gender VARCHAR(1));


INSERT INTO employee VALUES (12345, 'Fire', 'Sean', 2, 'M');
INSERT INTO employee VALUES (11234, 'Robertson', 'Luke', 2,'M');
INSERT INTO employee VALUES (12344, 'Gits', 'Samantha', 3,'F');
INSERT INTO employee VALUES (12234, 'Smith', 'Hyden',1,'M');


CREATE TABLE employee_experience
(Employee_ID INT REFERENCES employee (Employee_ID),
Driving_level​ INT,
Training_level​ INT,
Years_experience​ INT);
--CONSTRAINT emp_cnst REFERENCES employee(employee_ID) DISABLE;

INSERT INTO employee_experience VALUES (12345, 1, 2, 20);
INSERT INTO employee_experience VALUES (11234, 1, 2, 10);
INSERT INTO employee_experience VALUES (12344, 1, 2, 15);
INSERT INTO employee_experience VALUES (12234, 1, 2, 5);

--ALTER TABLE employee ENABLE CONSTRAINT superssn_cnst;

--Table: driving_time_log
CREATE TABLE driving_time_log
(Employee_ID INT REFERENCES employee (Employee_ID),
Log_date DATE,
Total_hours_day INT);

INSERT INTO driving_time_log VALUES (12345, TO_DATE('31-12-2020','DD-MM-YYYY'), 7);
INSERT INTO driving_time_log VALUES (11234, TO_DATE('31-12-2020','DD-MM-YYYY'), 7);
INSERT INTO driving_time_log VALUES (12234, TO_DATE('31-12-2020','DD-MM-YYYY'), 7);

CREATE TABLE driving_route_log
(Employee_ID INT REFERENCES employee (Employee_ID),
Log_date DATE,
Route_taken INT,
Bus_number_plate VARCHAR (6));

INSERT INTO driving_route_log VALUES (12345, TO_DATE('31-12-2020','DD-MM-YYYY'), 7,'PB4567');
INSERT INTO driving_route_log VALUES (12345, TO_DATE('31-12-2020','DD-MM-YYYY'), 5,'PB4567');
INSERT INTO driving_route_log VALUES (11234, TO_DATE('31-12-2020','DD-MM-YYYY'), 3,'PB4561');
INSERT INTO driving_route_log VALUES (11234, TO_DATE('31-12-2020','DD-MM-YYYY'), 4,'PB4561');

CREATE TABLE roster
(Employee_ID INT REFERENCES employee (Employee_ID),
Shift VARCHAR (7),
Day_of_the_week​ VARCHAR (3));

INSERT INTO roster VALUES (12345, 'Morning', 'Mon');
INSERT INTO roster VALUES (12345, 'Morning', 'Tue');
INSERT INTO roster VALUES (12345, 'Morning', 'Wed');
INSERT INTO roster VALUES (12345, 'Morning', 'Wed');
INSERT INTO roster VALUES (12345, 'Evening', 'Thu');
INSERT INTO roster VALUES (12345, 'Morning', 'Fri');
INSERT INTO roster VALUES (11234, 'Evening', 'Mon');
INSERT INTO roster VALUES (11234, 'Morning', 'Tue');
INSERT INTO roster VALUES (11234, 'Evening', 'Wed');
INSERT INTO roster VALUES (11234, 'Morning', 'Wed');
INSERT INTO roster VALUES (11234, 'Morning', 'Thu');
INSERT INTO roster VALUES (11234, 'Evening', 'Fri');

-- Customer (modeled by Cadence)

DROP TABLE customer CASCADE CONSTRAINTS;
CREATE TABLE customer (
  customer_email VARCHAR (320) PRIMARY KEY, -- email addresses can be up to 320 characters long
  full_name VARCHAR (4000) NOT NULL,                 -- names can be any length
  address VARCHAR (4000) NOT NULL,
  birthdate DATE NOT NULL,
  card_number CHAR (9) UNIQUE -- can be null if the customer has signed up and not purchased a card yet -- NOTE: add reference later
);

-- Bee card (modeled by Cadence)

DROP TABLE bee_card CASCADE CONSTRAINTS;
CREATE TABLE bee_card (
  card_number CHAR (9) PRIMARY KEY, -- bee card ids are exactly 9 digits long
  balance DECIMAL (6, 2) NOT NULL, -- bee card maximum balance is $2000, so this fits all the digits
  customer_email VARCHAR (320) NOT NULL UNIQUE, -- email addresses can be up to 320 characters long
  CONSTRAINT bee_card_balance_min CHECK (balance >= 0)
);

-- Trip (modeled by Cadence)
-- trip is a weak entity and has no primary key
DROP TABLE trip CASCADE CONSTRAINTS;
CREATE TABLE trip (
  trip_started DATE NOT NULL,
  trip_ended DATE NOT NULL,
  fare_charged DECIMAL (4, 2) NOT NULL,
  card_number CHAR (9) -- may be null because the trip may have been paid in cash
  bus_number_plate VARCHAR (6) NOT NULL, -- TODO: need to add reference
  employee_id INT NOT NULL,
  starts_at_stop INT NOT NULL, -- TODO: need to add reference
  ends_at_stop INT NOT NULL, -- TODO: need to add reference
  route_id INT NOT NULL,, -- TODO: need to add reference
);

-- Foreign key constraints for Cadence's tables

ALTER TABLE customer ADD FOREIGN KEY (card_number) REFERENCES bee_card (card_number);
ALTER TABLE bee_card ADD FOREIGN KEY (customer_email) REFERENCES customer (customer_email) ON DELETE CASCADE;
ALTER TABLE trip ADD FOREIGN KEY (card_number) REFERENCES bee_card (card_number) ON DELETE CASCADE;
ALTER TABLE trip ADD FOREIGN KEY (employee_id) REFERENCES employee (Employee_ID) ON DELETE CASCADE;


-- Zone (modeled by Alysha)
CREATE TABLE zone (
  zone_number VARCHAR(1) PRIMARY KEY, --Zones are only for dunedin area so there would never need to be more than 9
  card_price  DECIMAL(4,2) NOT NULL,
  cash_price  DECIMAL(4,2) NOT NULL,
  zone_colour VARCHAR(10) NOT NULL UNIQUE
);

INSERT INTO zone VALUES ('1', 1.60, 2.20, 'Blue');
INSERT INTO zone VALUES ('2', 2.50, 3.10, 'Yellow');
INSERT INTO zone VALUES ('3', 3.80, 4.50, 'Red'); 
INSERT INTO zone VALUES ('4', 10.00, 14.00, 'Grey');

-- Zone Suburbs (modeled by Alysha)
CREATE TABLE zone_suburbs (
  Z_Number VARCHAR(1) REFERENCES zone(zone_number),
  Z_Suburb VARCHAR(20),
  PRIMARY KEY(Z_Number, Z_suburb)
);

INSERT INTO zone_suburbs VALUES ('1', 'Centre City');
INSERT INTO zone_suburbs VALUES ('1', 'North Dunedin');
INSERT INTO zone_suburbs VALUES ('1', 'Roslyn');
INSERT INTO zone_suburbs VALUES ('2', 'South Dunedin');
INSERT INTO zone_suburbs VALUES ('2', 'North East Valley');
INSERT INTO zone_suburbs VALUES ('2', 'Pine Hill');
INSERT INTO zone_suburbs VALUES ('2', 'Kaikorai');
INSERT INTO zone_suburbs VALUES ('2', 'Caversham');
INSERT INTO zone_suburbs VALUES ('2', 'St Kila');
INSERT INTO zone_suburbs VALUES ('3', 'Wakari');
INSERT INTO zone_suburbs VALUES ('3', 'Andersons Bay');
INSERT INTO zone_suburbs VALUES ('3', 'Normanby');
INSERT INTO zone_suburbs VALUES ('4', 'Airport');

-- Stop (modeled by Alysha)
CREATE TABLE stop (
  stop_number 	varchar(3) PRIMARY KEY,
  address 	varchar(20) NOT NULL,
  shelter 	varchar(1) NOT NULL CHECK(shelter in('y','n')), --No boolean type
  bench 	varchar(1) NOT NULL CHECK(bench in('y','n')),
  Z_Number	varchar(1) REFERENCES zone(zone_number) NOT NULL
);

INSERT INTO stop VALUES ('198', 'Pine Hill Road', 'y', 'y', '2');
INSERT INTO stop VALUES ('17', 'North Rd', 'n', 'n', '2');
INSERT INTO stop VALUES ('226', 'South Rd', 'n', 'n', '2');
INSERT INTO stop VALUES ('319', 'Hillside Rd', 'n', 'y', '2');
INSERT INTO stop VALUES ('20', 'King Edward St', 'y', 'n', '2');
INSERT INTO stop VALUES ('138', 'Princes St', 'n', 'y', '1');
INSERT INTO stop VALUES ('314', 'George St', 'y', 'y', '1');
INSERT INTO stop VALUES ('594', 'Cumberland St', 'y', 'n', '1');
INSERT INTO stop VALUES ('145', 'Tahuna Rd', 'y', 'n', '3');
INSERT INTO stop VALUES ('3', 'Greenhill Ave', 'y', 'n', '3');
INSERT INTO stop VALUES ('37', 'Chapman St', 'n', 'y', '3');
INSERT INTO stop VALUES ('73', 'Highcliff Rd', 'n', 'y', '3');
INSERT INTO stop VALUES ('400', 'Airport', 'y', 'y', 4);

--BUS modeled by Sean
CREATE TABLE bus_make
(
    Model_ID CHAR(12) PRIMARY KEY CHECK(REGEXP_LIKE(Model_ID,'\d{12}')), --char 12 is used, as we assume this bus will have a 12 digit long number to identify it
    Capacity CHAR(2) NOT NULL CHECK(REGEXP_LIKE(Capacity,'\d{2}')) , -- the Capacity of the bus will  be a number between 10 and 99
    Safety_rating CHAR(3) NOT NULL CHECK(REGEXP_LIKE(Safety_rating,'[0-5]\.\d{1}')) , -- the saftey rating will be a number between 5 and 0, with one dp. because calcuations will never be used, varchar is best 
    Make VARCHAR(64) NOT NULL, -- the make of the bus
    Brand VARCHAR(64) NOT NULL -- the brand of the bus
);

INSERT INTO bus_make VALUES ('148163211332','10','1.1','big bus','ford');
INSERT INTO bus_make VALUES ('222211113333','45','1.1','small bus','holden');
CREATE TABLE bus
(
    Number_plate VARCHAR(6) PRIMARY KEY ,--Number plate has not fixed lenght and a max of 6 charaters
    Fuel_costs DECIMAL(8,2) CHECK (Fuel_costs > 0) NOT NULL, -- can't be negative. costs could pile up so large upper bound is set
    Repair_costs DECIMAL(8,2) CHECK (Repair_costs > 0) NOT NULL, -- can't be negative. costs could pile up so large upper bound is set
    Model_ID CHAR(12) NOT NULL CHECK(REGEXP_LIKE(Model_ID,'\d{12}')),-- keep info on what model the bus is 
    CONSTRAINT fk_model FOREIGN KEY(Model_ID)
    REFERENCES bus_make(Model_ID)
);

INSERT INTO bus VALUES ('xxxsss',100.51,1000,'222211113333');
INSERT INTO bus VALUES ('aaasss',105.51,10200,'222211113333');
INSERT INTO bus VALUES ('xxsss',100.51,1000,'148163211332');
INSERT INTO bus VALUES ('aasss',105.51,10200,'148163211332');

CREATE TABLE Condition
(
    Number_plate VARCHAR(6) PRIMARY KEY, -- is a composite attribute of bus
    Wheels VARCHAR(5) CHECK( Wheels IN ('good','ok','bad')),-- all conditons are limtied to there 3 groups
    Bus_body VARCHAR(5) CHECK( Bus_body IN ('good','ok','bad')),
    Transmission VARCHAR(5) CHECK( Transmission IN ('good','ok','bad')),
    Engine VARCHAR(5) CHECK( Engine IN ('good','ok','bad')),
    CONSTRAINT fk_condition FOREIGN KEY(Number_plate)
    REFERENCES bus(Number_plate)
);
INSERT INTO Condition VALUES ('xxxsss','good','bad','good','bad');
INSERT INTO Condition VALUES ('aaasss','bad','bad','good','bad');
INSERT INTO Condition VALUES ('xxsss','good','bad','ok','bad');
INSERT INTO Condition VALUES ('aasss','ok','bad','good','bad');

CREATE TABLE REGO-- is a composite attribute of bus
(
    Number_plate VARCHAR(6) UNIQUE NOT NULL ,
    ID CHAR(8) UNIQUE NOT NULL CHECK(REGEXP_LIKE(ID,'\d{8}')),
    Due DATE NOT NULL,
    DONE DATE NOT NULL,
    CONSTRAINT pk_rego PRIMARY KEY(Number_plate,ID),
    CONSTRAINT fk_rego FOREIGN KEY(Number_plate)
    REFERENCES bus(Number_plate)
);

INSERT INTO REGO VALUES ('xxxsss','77778888',TO_DATE('31-12-2022','DD-MM-YYYY'),TO_DATE('16-9-2015','DD-MM-YYYY'));
INSERT INTO REGO VALUES ('aaasss','99994444',TO_DATE('30-12-2023','DD-MM-YYYY'),TO_DATE('14-7-2016','DD-MM-YYYY'));
INSERT INTO REGO VALUES ('xxsss','22222222',TO_DATE('29-12-2024','DD-MM-YYYY'),TO_DATE('5-12-2017','DD-MM-YYYY'));
INSERT INTO REGO VALUES ('aasss','66677722',TO_DATE('28-12-2025','DD-MM-YYYY'),TO_DATE('31-3-2018','DD-MM-YYYY'));

CREATE TABLE WOF-- is a composite attribute of bus
(
    Number_plate VARCHAR(6),
    ID CHAR(8) UNIQUE NOT NULL CHECK(REGEXP_LIKE(ID,'\d{8}')),
    Due DATE NOT NULL,
    DONE DATE NOT NULL,
    CONSTRAINT pk_wof PRIMARY KEY(Number_plate,ID),
    CONSTRAINT fk_wof FOREIGN KEY(Number_plate)
    REFERENCES bus(Number_plate)
);

INSERT INTO WOF VALUES ('xxxsss','44442222',TO_DATE('31-12-2022','DD-MM-YYYY'),TO_DATE('16-9-2015','DD-MM-YYYY'));
INSERT INTO WOF VALUES ('aaasss','33333333',TO_DATE('30-12-2023','DD-MM-YYYY'),TO_DATE('14-7-2016','DD-MM-YYYY'));
INSERT INTO WOF VALUES ('xxsss','12345678',TO_DATE('29-12-2024','DD-MM-YYYY'),TO_DATE('5-12-2017','DD-MM-YYYY'));
INSERT INTO WOF VALUES ('aasss','99922211',TO_DATE('28-12-2025','DD-MM-YYYY'),TO_DATE('30-4-2018','DD-MM-YYYY'));

Create TABLE ROUTE
(
    Route_number varchar(2) PRIMARY KEY CHECK(REGEXP_LIKE(Route_number,'[0-9]+$')),
    colour varchar(16) NOT NULL UNIQUE
);

INSERT INTO route VALUES('1','red');
INSERT INTO route VALUES('2','blue');
INSERT INTO route VALUES('3','yellow');

-- Serviced By (modeled by Alysha)
CREATE TABLE serviced_by (
  S_Number      varchar(3) NOT NULL REFERENCES stop(stop_number),
  R_Number      VARCHAR(2) NOT NULL REFERENCES ROUTE(Route_number),
  time          VARCHAR(5) NOT NULL, --No datatype for just time, dont need date as the times are the same every day
  PRIMARY KEY(S_Number, R_Number)
);

INSERT INTO serviced_by VALUES ('198', '1', '10:00');
INSERT INTO serviced_by VALUES ('20', '1', '10:10');
INSERT IntO serviced_by VALUES ('314', '1', '10:19');
INSERT INTO serviced_by VALUES ('73', '2', '16:30');
INSERT INTO serviced_by VALUES ('37', '2', '16:38');
INSERT INTO serviced_by VALUES ('3', '2', '16:45');
INSERT INTO serviced_by VALUES ('314', '2', '17:00');
INSERT INTO serviced_by VALUES ('314', '3', '10:00');
INSERT INTO serviced_by VALUES ('400', '3', '11:00');
COMMIT;
