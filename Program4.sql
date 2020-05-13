CREATE DATABASE studentfacultyDB; 
USE studentfacultyDB;


CREATE TABLE STUDENT (
    snum INT,
    sname VARCHAR(20),
    major VARCHAR(20),
    lvl VARCHAR(20),
    age INT,
    PRIMARY KEY (snum)
);

CREATE TABLE FACULTY (
    fid INT,
    fname VARCHAR(20),
    deptid INT,
    PRIMARY KEY (fid)
);

CREATE TABLE CLASS (
    cname VARCHAR(30),
    meetsat TIMESTAMP,
    room VARCHAR(30),
    fid INT,
    PRIMARY KEY (cname),
    FOREIGN KEY (fid)
        REFERENCES Faculty (fid)
);

CREATE TABLE ENROLLED (
    snum INT,
    cname VARCHAR(30),
    PRIMARY KEY (snum , cname),
    FOREIGN KEY (snum)
        REFERENCES Student (snum),
    FOREIGN KEY (cname)
        REFERENCES Class (cname)
);

INSERT INTO STUDENT VALUES(1, 'John', 'CS', 'Sr', 19),(2, 'Smith', 'CS', 'Jr', 20),(3 , 'Jacob', 'CV', 'Sr', 20),(4, 'Tom ', 'CS', 'Jr', 20),(5, 'Rahul', 'CS', 'Jr', 20),(6, 'Rita', 'CS', 'Sr', 21);
INSERT INTO FACULTY VALUES(11, 'Harish', 1000),(12, 'MV', 1000),(13 , 'Mira', 1001),(14, 'Shiva', 1002),(15, 'Nupur', 1000);
INSERT INTO CLASS VALUES('class1', '12/11/15 10:15:16', 'R1', 14),('class10', '12/11/15 10:15:16', 'R128', 14),('class2', '12/11/15 10:15:20', 'R2', 12),('class3', '12/11/15 10:15:25', 'R3', 12),('class4', '12/11/15 20:15:20', 'R4', 14),('class5', '12/11/15 20:15:20', 'R3', 15),('class6', '12/11/15 13:20:20', 'R2', 14),('class7', '12/11/15 10:10:10', 'R3', 14);
INSERT INTO ENROLLED VALUES(1, 'class1'),(2, 'class1'),(3, 'class3'),(4, 'class3'),(5, 'class4'),(1, 'class5'),(2, 'class5'),(3, 'class5'),(4,'class5'),(5,'class5');

-- QUESTIONS:

-- 1
 SELECT DISTINCT sname 
 FROM STUDENT S, ENROLLED E , CLASS C, FACULTY  F
 WHERE F.fid=C.fid AND F.fname='MV' AND E.cname=C.cname AND S.snum=E.snum AND S.lvl ='jr';

-- 2
SELECT cname
FROM CLASS
WHERE room='R128' OR cname IN (SELECT DISTINCT cname 
				FROM ENROLLED
				GROUP BY cname
				HAVING COUNT(*)>=5);
                                
-- 3
SELECT sname
FROM STUDENT
WHERE snum IN (SELECT e1.snum 
		FROM ENROLLED e1, ENROLLED e2, CLASS c1, CLASS c2
		WHERE E1.snum=E2.snum AND E1.cname=C1.cname AND E2.cname=C2.cname AND E1.cname<>E2.cname AND C1.meetsat=C2.meetsat);
                
-- 4
SELECT DISTINCT F.fname 
FROM FACULTY F 
WHERE NOT EXISTS(SELECT room 
		 FROM CLASS 
                 WHERE room NOT IN (SELECT C1.room FROM CLASS C1 WHERE C1.fid = F.fid));
			
                
-- 5
SELECT DISTINCT fname
FROM FACULTY F
WHERE 5>(SELECT COUNT(E.snum)
	 FROM ENROLLED E, CLASS C
	 WHERE E.cname=C.cname AND C.fid=F.fid);
         
-- 6
SELECT sname
FROM STUDENT
WHERE snum NOT IN (SELECT snum FROM ENROLLED);
                    
-- 7
SELECT S.age, S.lvl
FROM STUDENT S
GROUP BY S.age, S.lvl
HAVING S.lvl IN (SELECT S1.lvl FROM STUDENT S1
                 WHERE S1.age = S.age
		 GROUP BY S1.lvl, S1.age
                 HAVING COUNT(*) >= ALL (SELECT COUNT(*)
					 FROM STUDENT S2
					 WHERE s1.age = S2.age
					 GROUP BY S2.lvl, S2.age));
