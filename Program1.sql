CREATE DATABASE INSURANCE;
USE INSURANCE;

-- QUESTIONS:

CREATE TABLE PERSON (
    driver_id VARCHAR(10),
    name VARCHAR(30),
    address VARCHAR(50),
    PRIMARY KEY (driver_id)
);

CREATE TABLE CAR (
    reg_num VARCHAR(10),
    model VARCHAR(30),
    year INT,
    PRIMARY KEY (reg_num)
);

CREATE TABLE OWNS (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    PRIMARY KEY (driver_id , reg_num),
    FOREIGN KEY (driver_id)
        REFERENCES PERSON (driver_id),
    FOREIGN KEY (reg_num)
        REFERENCES CAR (reg_num)
);

CREATE TABLE ACCIDENT (
    report_num INT,
    accident_date DATE,
    location VARCHAR(50),
    PRIMARY KEY (report_num)
);

CREATE TABLE PARTICIPATED (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    report_num INT,
    damage_amount INT,
    PRIMARY KEY (driver_id , reg_num , report_num),
    FOREIGN KEY (driver_id)
        REFERENCES PERSON (driver_id),
    FOREIGN KEY (reg_num)
        REFERENCES CAR (reg_num),
    FOREIGN KEY (report_num)
        REFERENCES ACCIDENT (report_num)
);


-- 2
INSERT INTO PERSON VALUES("A01","Richard","Srinivas nagar"),
("A02","Pradeep","Rajaji nagar"),
("A03","Smith","Ashok nagar"),
("A04","Venu","NR colony"),
("A05","John","Hanumanth nagar");

INSERT INTO CAR VALUES("KA052250","Indica",1990),
("KA031181","Lancer",1957),
("KA095477","Toyota",1998),
("KA053408","Honda",2008),
("KA041702","Audi",2005);

INSERT INTO OWNS VALUES("A01","KA052250"),
("A02","KA053408"),
("A03","KA031181"),
("A04","KA095477"),
("A05","KA041702");

INSERT INTO ACCIDENT VALUES(11,"2003-01-01","Mysore road"),
(12,"2004-02-02","South end circle"),
(13,"2003-01-21","Bull temple road"),
(14,"2008-02-17","Mysore road"),
(15,"2005-03-04","Kanakpura road");

INSERT INTO PARTICIPATED VALUES("A01","KA052250",11,10000),
("A02","KA053408",12,50000),
("A03","KA095477",13,25000),
("A04","KA031181",14,3000),
("A05","KA041702",15,5000);


-- 3(a)
UPDATE PARTICIPATED 
SET 
    damage_amount = 25000
WHERE
    reg_num = 'KA053408' AND report_num = 12;
-- 3(b)
INSERT INTO ACCIDENT VALUES(16,"2019-01-03","Hanumanth nagar");


-- 4
SELECT 
    COUNT(DISTINCT driver_id) CNT
FROM
    PARTICIPATED,
    ACCIDENT
WHERE
    PARTICIPATED.report_num = ACCIDENT.report_num
        AND accident_date LIKE '2008%';


-- 5
SELECT 
    COUNT(DISTINCT model) ACC_MOD
FROM
    PARTICIPATED,
    CAR
WHERE
    PARTICIPATED.reg_num = CAR.reg_num
        AND CAR.model = 'Toyota';
