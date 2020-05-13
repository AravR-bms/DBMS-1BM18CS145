create database airlineflightDB;
use airlineflightDB;


CREATE TABLE FLIGHTS (
	FLNO INTEGER PRIMARY KEY,
	FFROM VARCHAR(15) NOT NULL,
	TTO VARCHAR(15) NOT NULL,
	DISTANCE INTEGER,
	DEPARTS TIMESTAMP,
	ARRIVES TIMESTAMP,
	PRICE INT
  );

CREATE TABLE AIRCRAFT (
	AID INTEGER PRIMARY KEY,
	ANAME VARCHAR(10),
	CRUISINGRANGE INTEGER
	);

CREATE TABLE EMPLOYEES (
	EID INTEGER PRIMARY KEY,
	ENAME VARCHAR(15),
	SALARY INT
    );
    
CREATE TABLE CERTIFIED (
	EID INTEGER NOT NULL,
	AID INTEGER NOT NULL,
	PRIMARY KEY (EID, AID),
	FOREIGN KEY (EID) REFERENCES EMPLOYEES (EID),
	FOREIGN KEY (AID) REFERENCES AIRCRAFT (AID)
  );
insert into FLIGHTS values(101,'Bangalore','Delhi',2500,'2005-05-13 07:15:31','2005-05-13 17:15:31',5000),(102,'Bangalore','Lucknow',3000,'2005-05-13 07:15:31','2005-05-13 11:15:31',6000),(103,'Lucknow','Delhi',500,'2005-05-13 12:15:31',' 2005-05-13 17:15:31',3000),
(107,'Bangalore','Frankfurt',8000,'2005-05-13 07:15:31','2005-05-13 22:15:31',60000),(104,'Bangalore','Frankfurt',8500,'2005-05-13 07:15:31','2005-05-13 23:15:31',75000),(105,'Kolkata','Delhi',3400,'2005-05-13 07:15:31','2005-05-13 09:15:31',7000);
insert into AIRCRAFT values(101,'747',3000),(102,'Boeing',900),(103,'647',800),(104,'Dreamliner',10000),(105,'Boeing',3500),(106,'707',1500),(107,'Dream', 120000);
insert into EMPLOYEES values(701,'A',50000),(702,'B',100000),(703,'C',150000),(704,'D',90000),(705,'E',40000),(706,'F',60000),(707,'G',90000);
insert into CERTIFIED values(701,101),(701,102),(701,106),(701,105),(702,104),(703,104),(704,104),(702,107),(703,107),(704,107),(702,101),(703,105),(704,105),(705,103);


-- 1
select distinct aname 
from AIRCRAFT A, EMPLOYEES E, CERTIFIED C
where A.aid=C.aid and E.eid=C.eid and E.salary>80000;

-- 2
select C.eid, max(a.cruisingrange)
from AIRCRAFT A, CERTIFIED C
where C.aid=A.aid
group by C.eid
having count(*)>3;

-- 3
select ename
from EMPLOYEES
where salary<(select min(price)
				from FLIGHTS
                where ffrom='Bangalore' and tto='Frankfurt');
    
-- 4
select A.aname, avg(E.salary) avg_salary
from AIRCRAFT A, EMPLOYEES E, CERTIFIED C
where A.aid=C.aid and A.cruisingrange>1000 and E.eid=C.eid
group by A.aname;


-- 5
select distinct E.ename
from AIRCRAFT A, EMPLOYEES E, CERTIFIED C
where A.aid=C.aid and E.eid=C.eid and A.aname='Boeing';

-- 6
select A.aid
from AIRCRAFT A
where A.cruisingrange>(select min(f.distance)
						from FLIGHTS F
						where F.ffrom='Bangalore' AND F.tto='Delhi');


-- 6
SELECT F.departs
FROM Flights F
WHERE F.flno IN ( ( SELECT F0.flno
 FROM Flights F0
 WHERE F0.ffrom = 'Bangalore' AND F0.tto = 'Delhi'
 AND extract(hour from F0.arrives) < 18 )
 UNION
( SELECT F0.flno
 FROM Flights F0, Flights F1
 WHERE F0.ffrom = 'Bangalore' AND F0.tto <> 'Delhi'
 AND F0.tto = F1.ffrom AND F1.tto = 'Delhi'
 AND F1.departs > F0.arrives
 AND extract(hour from F1.arrives) < 18)
 UNION
( SELECT F0.flno
 FROM Flights F0, Flights F1, Flights F2
 WHERE F0.ffrom = 'Bangalore'
 AND F0.tto = F1.ffrom
 AND F1.tto = F2.ffrom
 AND F2.tto = 'Delhi'
 AND F0.tto <> 'Delhi'
 AND F1.tto <> 'Delhi'
 AND F1.departs > F0.arrives
 AND F2.departs > F1.arrives
 AND extract(hour from F2.arrives) < 18));
 
-- 7
SELECT E.ename, E.salary
FROM Employees E
WHERE E.eid NOT IN ( SELECT DISTINCT C.eid
 FROM Certified C )
AND E.salary >( SELECT AVG (E1.salary)
 FROM Employees E1
 WHERE E1.eid IN
( SELECT DISTINCT C1.eid
 FROM Certified C1 ) );
