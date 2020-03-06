create database bank;
use bank;
create table BRANCH(
branch_name varchar(30),
branch_city varchar(30),
assets REAL,
primary key(branch_name));
drop table branch;

create table ACCOUNTS(
accno int,
branch_name varchar(30),
balance REAL,
primary key(accno),
foreign key(branch_name)references branch(branch_name));

create table bankcustomer(
customer_name varchar(30),
customer_street varchar(30),
customer_city varchar(30),
primary key(customer_name));

create table depositor (
customer_name varchar(30),
accno int,
primary key (customer_name),
foreign key(customer_name) references bankcustomer(customer_name));
drop table depositor;

create table LOAN(
loan_number int,
branch_name varchar(30),
amount REAL,
primary key(loan_number),
foreign key(branch_name)references branch(branch_name));

insert into branch values ("KG road","Blore",10000);
insert into branch values ("RV road","Blore",20000);
insert into branch values ("BVK road","Blore",30000);
insert into branch values ("KR road","Blore",40000);
insert into branch values ("MG road","Blore",50000);

insert into accounts values (101,"KG road",2000);
insert into accounts values (102,"RV road",4000);
insert into accounts values (103,"BVK road",6000);
insert into accounts values (104,"KR road",8000);
insert into accounts values (105,"MG road",10000);

insert into bankcustomer values ("ABC","Basavangudi","Blore");
insert into bankcustomer values ("PQR","Jayanagar","Blore");
insert into bankcustomer values ("MNO","JP Nagar","Blore");
insert into bankcustomer values ("WXY","MG Road","Blore");
insert into bankcustomer values ("BBB","KG Road","Blore");

insert into depositor values ("ABC",101);
insert into depositor values ("PQR",102);
insert into depositor values ("MNO",103);
insert into depositor values ("WXY",104);
insert into depositor values ("BBB",105);

insert into loan values (100,"KG road",1000);
insert into loan values (200,"Rv road",2000);
insert into loan values (300,"BVK road",3000);
insert into loan values (400,"KR road",4000);
insert into loan values (500,"MG road",5000);
