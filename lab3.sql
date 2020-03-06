create database table3;
use table3;
create table supplier(
sid int,
sname varchar(100),
city varchar(50),
primary key(sid)
);
create table parts(
pid int,
pname varchar(20),
color varchar(10),
primary key(pid)
);
create table catalog(
sid int,
pid int,
cost varchar(10),
primary key(sid,pid),
foreign key (sid) references supplier (sid),
foreign key (pid) references parts (pid)
);
insert into supplier values(10001,"Acme Widet","Banalore");
insert into supplier values(10002,"Johns","Kolkata");
insert into supplier values(10003,"Vimal","Mumbai");
insert into supplier values(10004,"Reliance","Delhi");
insert into parts values(20001,"Book","Red");
insert into parts values(20002,"Pen","Red");
insert into parts values(20003,"Pencil","Green");
insert into parts values(20004,"Mobile","Green");
insert into parts values(20005,"Charger","Black");
insert into catalog values(10001,20001,10);
insert into catalog values(10001,20002,10);
insert into catalog values(10001,20003,30);
insert into catalog values(10001,20004,10);
insert into catalog values(10001,20005,10);
insert into catalog values(10002,20001,10);
insert into catalog values(10002,20002,20);
insert into catalog values(10003,20003,30);
insert into catalog values(10004,20003,40);
select * from catalog;
select * from parts;
© 2020 GitHub, Inc.
