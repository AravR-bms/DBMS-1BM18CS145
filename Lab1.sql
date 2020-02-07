use cs145;
create table rest(ID varchar(30) primary key, r_name varchar(50), location varchar(100), rating float);
select * from rest;
insert into rest values("001", "Chinese Square", "Basavangudi", NULL);
insert into rest values("002", "Rolls on Wheels", "Hanumanth Nagar", NULL);
insert into rest values("003", "Bhavani", "Bull Temple Road", NULL);
insert into rest values("004", "Schezwan Dragon", "Above Rolls on Wheels", NULL);
insert into rest values("005", "Utsav", "BMSCE Backside", NULL);
insert into rest values("006", "RoofTop", "Jayanagar", NULL);
insert into rest values("007", "Megahana Foods", "Across Bengaluru", NULL);
create table rev(CID varchar(30) primary key, name varchar(30), ID varchar(30), FOREIGN KEY(ID) REFERENCES rest(ID));
alter table rev add column (rating int check (rating <6 and rating >0) );
insert into rev values("C01", "Ajay", "001", 3);
insert into rev values("C02", "Akshay", "001", 4);
insert into rev values("C03", "Khrithik", "001", 5);
insert into rev values("C04", "Bhushith", "001", 4);
insert into rev values("C05", "Krishna", "001", 4);
insert into rev values("C06", "Harshit", "001", 5);
insert into rev values("C07", "Nidhish", "001", 1);
select * from rev;







