CREATE TABLE Employee (
	employee_id INT NOT NULL AUTO_INCREMENT,
	employee_name VARCHAR(100) NOT NULL,
	employee_email VARCHAR(200) NOT NULL,
	employee_phone CHAR(10) NOT NULL,
	employee_address VARCHAR(100) NOT NULL,
	date_of_joining DATE NOT NULL,
	overtime_payabale BOOL NOT NULL,
    PRIMARY KEY(employee_id)
);


CREATE TABLE PayInformation (
	designation_id INT NOT NULL,
	designation_name VARCHAR(50) NOT NULL,
	hourly_pay DOUBLE NOT NULL,
	PRIMARY KEY (designation_id)
);


CREATE TABLE Project (
	project_id INT NOT NULL AUTO_INCREMENT,
	project_name VARCHAR(200) NOT NULL,
	project_budget DOUBLE NOT NULL,
	PRIMARY KEY (project_id)
);


CREATE TABLE EmployeeStatus(
	employee_idt INT NOT NULL,
	project_idt INT,
	designation_idt INT NOT NULL,
    FOREIGN KEY (employee_idt) REFERENCES Employee(employee_id),
    FOREIGN KEY (project_idt) REFERENCES Project(project_id),
    FOREIGN KEY (designation_idt) REFERENCES PayInformation(designation_id)
    ON DELETE CASCADE
);


CREATE TABLE EmployeeBench(
	employee_idb INT NOT NULL,
	bench_start_date DATE,
	bench_end_date DATE,
	FOREIGN KEY(employee_idb) REFERENCES Employee(employee_id)
    ON DELETE CASCADE
);


CREATE TABLE Login (
	employee_idl INT NOT NULL,
	login_time DATETIME,
	logout_time DATETIME,
	FOREIGN KEY(employee_idl) REFERENCES Employee(employee_id)
    ON DELETE CASCADE
);


CREATE TABLE BiweeklySalary(
    Trans_id INT AUTO_INCREMENT PRIMARY KEY,
	employee_idbs INT NOT NULL,
	salary_credited_date DATE,
	paid_hours INT,
	stat_holiday_hours INT,
	employee_account_number VARCHAR(100),
	salary_amount FLOAT,
	FOREIGN KEY(employee_idbs) REFERENCES Employee(employee_id)
    ON DELETE CASCADE
);


CREATE TABLE SalaryRecords(
	employee_ids INT NOT NULL,
	salary_start_date DATE,
	salary_end_date DATE,
	FOREIGN KEY(employee_ids) REFERENCES Employee(employee_id)
    ON DELETE CASCADE
);



CREATE TABLE StatHolidays (
	stat_holiday_date DATE
);

CREATE TABLE CompanyExpenditure (
	salary FLOAT,
	tax FLOAT,
    cost_to_company FLOAT
);

SHOW TABLES;

DESC Employee;
DESC PayInformation;
DESC Project;
DESC EmployeeStatus;
DESC EmployeeBench;
DESC Login;
DESC SalaryRecords;
DESC BiweeklySalary;
DESC StatHolidays;
DESC CompanyExpenditure;

#Insert data in Tables#
insert into Employee (employee_name, employee_email, employee_phone, employee_address, date_of_joining, overtime_payabale)
values('Akshay','akshay@gmail.com','7267687789','Mccallum','2018-11-10',1),
	  ('Rahul','rahul@gmail.com','7264560992','Kind Rd','2017-1-16',1),
      ('Gurjit','gurjit@gmail.com','7264550225','UFV Rd','2015-10-11',0),
      ('Ishaan','ishaan@gmail.com','7237562345','Mcullaum dr','2017-1-16',1),
      ('Joseph','joseph@gmail.com','7269840938','Robson St','2017-1-16',0);


select * from Employee;

insert into PayInformation 
values(3001,'Programmers',20.5),
      (3002,'Senior consultant',32.5),
      (3003,'Consultant',25.2),
      (3004,'Contractors',28.0);

select * from PayInformation;

insert into Project (project_name, project_budget)
values('PROJ1',25000),
      ('PROJ2',30010),
      ('PROJ3',98000),
      ('PROJ4',45789),
      ('PROJ5',65879);

select * from Project;

insert into EmployeeStatus (employee_idt, project_idt, designation_idt)
values(1,1,3001),
      (2,3,3002),
      (3,4,3003),
      (4,4,3004),
      (5,5,3002);

select * from EmployeeStatus;

insert into EmployeeBench (employee_idb, bench_start_date, bench_end_date)
values(1,'2019-08-09','2019-09-10'),
      (5,'2019-09-30','2019-10-15');

select * from EmployeeBench;

insert into Login 
values(1,'2019-09-29 8:00:17','2019-09-29 17:00:15'),
      (2,'2019-09-29 8:00:20','2019-09-29 18:00:30'),
      (3,'2019-09-29 8:00:11','2019-09-29 16:00:40'),
      (4,'2019-09-29 8:00:12','2019-09-29 20:00:45'),
      (5,'2019-09-29 8:00:09','2019-09-29 19:00:32');

select * from Login;


insert into BiweeklySalary (employee_idbs, salary_credited_date, paid_hours, stat_holiday_hours, employee_account_number, salary_amount)
values(1,'2019-10-2',39.5,0,'1002612401',10000),
      (2,'2019-10-2',36,0,'1002612402',8000),
      (3,'2019-10-2',38.5,0,'1002612403',9000),
      (4,'2019-10-2',32,0,'1002612405',6000),
      (5,'2019-10-2',33,0,'1002612406',7000);

select * from BiweeklySalary;



insert into SalaryRecords 
values(1,'02-06-2018','31-10-2019'),
      (2,'01-01-2017','01-06-2018'),
      (3,'02-01-2015','31-12-2016'),
      (4,'02-03-2014','01-01-2015'),
      (5,'04-04-2013','01-03-2014');
      
      
select * from SalaryRecords;

insert into StatHolidays 
values('11-10-2018'),
      ('02-03-2018'),
      ('08-09-2016'),
      ('09-01-2015'),
      ('19-02-2014');
      
select * from StatHolidays;
 
insert into CompanyExpenditure 
values(10000,1200,11200),
      (8000,1212,9212),
      (9000,1500,10500),
      (6000,922,6922),
      (7000,980,7980);
 
select * from CompanyExpenditure;	

 #Views#

Create View ProjectProfit AS Select Project_Budget, Project_Name from Project;

Create View PaymentPerHour AS Select Hourly_Pay from PayInformation;

Create View EmployeePayments AS Select Paid_Hours,Salary_Amount from BiweeklySalary;

select * from ProjectProfit;

select * from PaymentPerHour;

select * from EmployeePayments;





CREATE PROCEDURE GetallActiveEmployees
AS
Select 
a.employee_name, 
a.employee_id, 
a.employee_phone,
Projectname as (select c.project_name from Project c where c.project_id= b.project_id)
from
Employee a , EmployeeStatus b
where a.employee_id = b.employee_id
and b.project_id is not null;
GO;


EXEC GetallActiveEmployees;






CREATE PROCEDURE GetallOvertimeEmployees
AS
Select 
a.employee_name, 
a.employee_id, 
Projectname as (select c.project_name from Project c where c.project_id= b.project_id)
from
Employee a , EmployeeStatus b, Login l
where a.employee_id = b.employee_id
and l.employee_id = a.employee_id
and l.employee_id = b.employee_id
and (l.logout_time - l.login_time) > 8
and b.project_id is not null;
GO;


EXEC GetallOvertimeEmployees;


#The HAVING clause was added to SQL because the WHERE keyword could not be used with aggregate functions.
#Now, I can use the below query to retrieve all the project_id’s that have more than 10 employees assigned.


SELECT COUNT(employee_id ), project_id 
FROM EmployeeStatus
GROUP BY project_id 
Having COUNT(employee_id ) >10 ;



#The GROUP BY statement groups rows that have the same values into summary rows.
#The GROUP BY statement is often used with aggregate functions (COUNT, MAX, MIN, SUM, AVG) to group the result-set by one or more columns.
#For instance, I need to see count of employees assigned to a single project. Below query gives number of employees for each project.


SELECT COUNT(employee_id ), project_id 
FROM EmployeeStatus
GROUP BY project_id ;


