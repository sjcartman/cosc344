DROP TABLE employee_experience;
DROP TABLE driving_time_log;
DROP TABLE driving_route_log;
DROP TABLE roster;
DROP TABLE employee cascade constraints;


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
  full_name VARCHAR (4000),                 -- names can be any length
  address VARCHAR (4000),
  birthdate DATE,
  card_number CHAR (9) UNIQUE -- NOTE: add reference later
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

COMMIT;
