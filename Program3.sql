CREATE DATABASE supplierDB;
USE supplierDB;


CREATE TABLE SUPPLIERS (
    sid INT,
    sname VARCHAR(30),
    city VARCHAR(30),
    PRIMARY KEY (sid)
);

CREATE TABLE PARTS (
    pid INT,
    pname VARCHAR(30),
    color VARCHAR(30),
    PRIMARY KEY (pid)
);

CREATE TABLE CATALOG (
    sid INT,
    pid INT,
    cost INT,
    PRIMARY KEY (sid , pid),
    FOREIGN KEY (sid)
        REFERENCES SUPPLIERS (sid),
    FOREIGN KEY (pid)
        REFERENCES PARTS (pid)
);

INSERT INTO SUPPLIERS VALUES(10001,'Acme Widget','Bangalore'),(10002,'Johns','Kolkata'),(10003,'Vimal','Mumbai'),(10004,'Reliance','Delhi');
INSERT INTO PARTS VALUES(20001,'Book','Red'),(20002,'Pen','Red'),(20003,'pencil','Green'),(20004,'Mobile','Green'),(20005,'Charger','Black');
INSERT INTO CATALOG VALUES(10001,20001,10),(10001,20002,10),(10001,20003,30),(10001,20004,10),(10001,20005,10),(10002,20001,10),(10002,20002,20),(10003,20003,30),(10004,20003,40);


-- QUESTIONS:

-- 1
SELECT pname
FROM PARTS P, CATALOG C
WHERE P.pid=C.pid;

-- 2
SELECT S.sname
FROM SUPPLIERS S
WHERE NOT EXISTS (SELECT P.pid FROM PARTS P WHERE P.pid
		  NOT IN (SELECT DISTINCT C.pid FROM CATALOG C WHERE C.sid=S.sid));

-- 3
SELECT sname 
FROM SUPPLIERS S
WHERE NOT EXISTS (SELECT pid FROM PARTS WHERE color='Red'
		  NOT IN (SELECT DISTINCT C.pid 
			  FROM CATALOG C, PARTS P
			  WHERE P.pid=C.pid AND P.color='Red' AND C.sid=S.sid));

-- 4
SELECT pname
FROM PARTS P, CATALOG C, SUPPLIERS S
WHERE C.pid=P.pid AND C.sid=S.sid 
AND S.sname='Acme Widget' AND C.pid 
	NOT IN (SELECT c.pid 
		FROM CATALOG C, SUPPLIERS S
		WHERE S.sid=C.sid AND S.sname<>'Acme Widget');
                            
-- 5
SELECT sid
FROM CATALOG C
WHERE C.cost>(SELECT AVG(C2.cost) FROM CATALOG C2 WHERE C.pid=C2.pid);
