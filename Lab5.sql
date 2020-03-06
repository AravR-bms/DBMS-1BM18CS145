create database lab4;
use lab4;

create table STUDENT(
	snum int,
    primary key (snum),
    sname varchar(100),
    major varchar(50),
    lvl varchar(20),
    age int    
);

create table FACULTY(
	fid int,
    primary key(fid),
    fname varchar(100),
    deptid int not null
);

create table CLASS(
	cname varchar(64),
    primary key(cname),
    meets_at time,
    room varchar(30),
    fid int not null ,
    foreign key(fid) references FACULTY(fid)
);

create table ENROLLED(
	snum int,    
	cname varchar(64),
    primary key (snum, cname),
    foreign key(snum) references STUDENT(snum) on delete cascade,
    foreign key(cname) references CLASS(cname) on delete cascade
);

insert into STUDENT 
values (1, "Kreshna", "Python", "FR", 69),
	(2, "Kreetik", "Gamer", "JR", 21),
    (3, "Kenisqh", "Balling", "SO", 17),
    (4, "Kartik", "Money", "SR", 23),
    (5, "Hersheit", "WebDev", "SO", 20),
    (6, "Harushh", "Protcol", "SR", 25),
    (7, "Chaa", "Biriyani", "FR", 19);
    
insert into FACULTY
values (1, "KVN", 1), (2, "PS", 2), (3, "NM", 1), (4, "GS", 1), (5, "CS", 2);

insert into CLASS
values ("ADA", "10:30:00", "C407", 3),
	("DBMS", "11:30:00", "C408", 1),
    ("OS", "15:30:00", "C407", 2),
    ("LA", "13:00:00", "C407", 5),
    ("TFCS", "08:30:00", "C408", 4);
    
insert into ENROLLED
values (1,"DBMS"), (2, "DBMS"), (3, "LA"), (4, "OS"), (5, "TFCS"), (6, "ADA"), (7, "LA");

--Quries Not done


