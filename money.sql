CREATE TABLE shzhi(id integer primary key autoincrement,type text,total real,danjia real,shuliang real,note text,time timestamp default(datetime('now','localtime')),number real);
CREATE VIEW v1 as select type,number,note,time from shzhi group by type;
CREATE VIEW v2 as select sum(number) as total from v1;
CREATE TRIGGER t2 after insert on shzhi begin insert into shzhi(type,danjia,shuliang,note) select  new.note,-new.danjia,new.shuliang,new.type where exists(select * from shzhi where type=new.note);end;
CREATE TRIGGER t1 after insert on shzhi begin update shzhi set total=round(danjia*shuliang,3),number=round((select number from shzhi where id=(select max(id) from shzhi where type=new.type and total is not null))-danjia*shuliang,3) where id=new.id;end;
