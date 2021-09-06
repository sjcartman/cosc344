DROP TABLE employee_experience; 
DROP TABLE driving_time_log; 
DROP TABLE driving_route_log; 
DROP TABLE roster; 
DROP TABLE employee cascade constraints;

--Table: driving_time_log 
CREATE TABLE employee 
(Employee_ID INT (5) PRIMARY KEY,
lname VARCHAR(15) NOT NULL, 
fname VARCHAR(15) NOT NULL, 
Age_bracket INT , 
Gender VARCHAR(1));


INSERT INTO employee VALUES (12345, “Fire”, “Sean”, 2, M);
INSERT INTO employee VALUES (11234, “Robertson”, “Luke”, 2,M); 
INSERT INTO employee VALUES (12344, “Gits”, “Samantha”, 3,F); 
INSERT INTO employee VALUES (12234, “Smith”, “Hyden”,1,M);

--Table: driving_time_log 
CREATE TABLE employee _experience
(Employee_ID INT (5) REFERENCES employee (Employee_ID),
Driving_level​ INT (1),
Training_level​ INT (1),
Years_experience​ INT (2));
--CONSTRAINT emp_cnst REFERENCES employee(employee_ID) DISABLE;


INSERT INTO employee_experience VALUES (12345, 1, 2, 20);
INSERT INTO employee_experience VALUES (11234, 1, 2, 10); 
INSERT INTO employee_experience VALUES (12344, 1, 2, 15); 
INSERT INTO employee_experience VALUES (12234, 1, 2, 5);

--ALTER TABLE employee ENABLE CONSTRAINT superssn_cnst;

--Table: driving_time_log 
CREATE TABLE driving_time_log
(Employee_ID INT (5) REFERENCES employee (Employee_ID),
Log_date DATE;
Total_hours_day INT (2));

INSERT INTO driving_time_log VALUES (12345, TO_DATE('31-12-2020','DD-MM-YYYY’)), 7);
INSERT INTO driving_time_log VALUES (11234, TO_DATE('31-12-2020','DD-MM-YYYY’)), 7);
INSERT INTO driving_time_log VALUES (12234, TO_DATE('31-12-2020','DD-MM-YYYY’)), 7);

CREATE TABLE driving_route_log
(Employee_ID INT (5) REFERENCES employee (Employee_ID),
Log_date DATE,
Route_taken INT (2),
Bus_number_plate VARCHAR (6);

INSERT INTO driving_route_log VALUES (12345, TO_DATE('31-12-2020','DD-MM-YYYY’)), 7,PB4567);
INSERT INTO driving_route_log VALUES (12345, TO_DATE('31-12-2020','DD-MM-YYYY’)), 5,PB4567);
INSERT INTO driving_route_log VALUES (11234, TO_DATE('31-12-2020','DD-MM-YYYY’)), 3,PB4561);
INSERT INTO driving_route_log VALUES (11234, TO_DATE('31-12-2020','DD-MM-YYYY’)), 4,PB4561);

CREATE TABLE roster
(Employee_ID INT (5) REFERENCES employee (Employee_ID),
Shift VARCHAR (7),
Day_of_the_week​ VARCHAR (3));

INSERT INTO roster VALUES (12345, Morning, Mon);
INSERT INTO roster VALUES (12345, Morning, Tue);
INSERT INTO roster VALUES (12345, Morning, Wed);
INSERT INTO roster VALUES (12345, Morning, Wed);
INSERT INTO roster VALUES (12345, Evening, Thu);
INSERT INTO roster VALUES (12345, Morning, Fri);
INSERT INTO roster VALUES (11234, Evening, Mon);
INSERT INTO roster VALUES (11234, Morning, Tue);
INSERT INTO roster VALUES (11234, Evening, Wed);
INSERT INTO roster VALUES (11234, Morning, Wed);
INSERT INTO roster VALUES (11234, Morning, Thu);
INSERT INTO roster VALUES (11234, Evening, Fri);


Commit;


