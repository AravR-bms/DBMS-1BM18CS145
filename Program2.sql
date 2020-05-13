CREATE DATABASE bankingenterpriseDB;
USE bankingenterpriseDB;


CREATE TABLE Branch (
    branch_name VARCHAR(30),
    branch_city VARCHAR(10),
    assets REAL,
    PRIMARY KEY (branch_name)
);

CREATE TABLE Bank_account (
    acc_no INT,
    branch_name VARCHAR(30),
    balance REAL,
    PRIMARY KEY (acc_no),
    FOREIGN KEY (branch_name)
        REFERENCES BRANCH (branch_name)
);

CREATE TABLE Bank_Customer (
    customername VARCHAR(30),
    customerstreet VARCHAR(30),
    customercity VARCHAR(30),
    PRIMARY KEY (customername)
);

CREATE TABLE Depositor (
    customername VARCHAR(30),
    acc_no INT,
    PRIMARY KEY (customername , acc_no),
    FOREIGN KEY (customername)
        REFERENCES Bank_Customer (customername),
    FOREIGN KEY (acc_no)
        REFERENCES Bank_account (acc_no)
);

CREATE TABLE Loan (
    loan_num INT,
    branch_name VARCHAR(30),
    amount REAL,
    PRIMARY KEY (loan_num),
    FOREIGN KEY (branch_name)
        REFERENCES Branch (branch_name)
);

-- 2
INSERT INTO Branch VALUES(
'SBI_Chamrajpet','Bangalore',50000),
("SBI_ResidencyRoad","Bangalore",10000),
("SBI_ShivajiRoad","Bombay",20000),
("SBI_ParliamentRoad","Delhi",10000),
("SBI_Jantarmantar","Delhi",20000);

INSERT INTO Bank_account VALUES(
1,"SBI_Chamrajpet",2000),(2,"SBI_ResidencyRoad",5000),(3,"SBI_ShivajiRoad",6000),(4,"SBI_ParliamentRoad",9000),(5,"SBI_Jantarmantar",8000),(6,"SBI_ShivajiRoad",4000),(8,"SBI_ResidencyRoad",4000),(9,"SBI_ParliamentRoad",3000),(10,"SBI_ResidencyRoad",5000),(11,"SBI_Jantarmantar",2000);

INSERT INTO Bank_Customer VALUES("Avinash","Bull Temple Road","Bangalore"),
("Dinesh","Bannergatta Road","Bangalore"),
("Mohan","National College Road","Bangalore"),
("Nikil","Akbar Road","Delhi"),
("Ravi","Prithviraj Road","Delhi");

INSERT INTO Loan VALUES(1,"SBI_Chamrajpet",1000),(2,"SBI_ResidencyRoad",2000),(3,"SBI_ShivajiRoad",3000),(4,"SBI_ParliamentRoad",4000),(5,"SBI_Jantarmantar",5000);
INSERT INTO Depositor VALUES("Avinash",1),("Dinesh",2),("Nikil",4),("Ravi",5),("Avinash",8),("Nikil",9),("Dinesh",10),("Nikil",11);


-- 3
SELECT C.customername 
FROM Bank_Customer C
WHERE EXISTS (  SELECT D.customername, COUNT(D.customername)
                FROM Depositor D,Bank_account BA
                WHERE
                D.acc_no = BA.acc_no AND C.customername = D.customername AND BA.branch_name='SBI_ResidencyRoad' 
                GROUP BY D.customername
                HAVING COUNT(D.customername) >=2);
-- 4
SELECT BC.customername FROM Bank_Customer BC WHERE NOT EXISTS(
	SELECT branch_name FROM Branch WHERE branch_city = 'Delhi'
	AND branch_name NOT IN(
    SELECT BA.branch_name FROM Depositor D, Bank_account BA
	WHERE D.acc_no = BA.acc_no AND BC.customername = D.customername)
);


-- 5
DELETE FROM Bank_account 
WHERE branch_name IN (SELECT branch_name 
					  FROM Branch
                      WHERE branch_city='Bombay');
SELECT * FROM Bank_account;
