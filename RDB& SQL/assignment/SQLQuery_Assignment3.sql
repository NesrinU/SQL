/*a.    Create above table (Actions) and insert values,*/

CREATE TABLE Actions(
    Visitor_ID int,
    Adv_Type VARCHAR(15),
    Action VARCHAR(15)
    )
INSERT INTO Actions (Visitor_ID, Adv_Type, Action )
VALUES
(1,'A','Left'),
(2,'A','Order'),
(3,'B','Left'),
(4,'A','Order'),
(5,'A','Review'),
(6,'A','Left'),
(7,'B','Left'),
(8,'B','Order'),
(9,'B','Review'),
(10,'A','Review');


SELECT * FROM Actions

/*

b.    Retrieve count of total Actions and Orders for each Advertisement Type,*/

select Adv_type , count([Action]) as cnt
from Actions
where [Action]= 'Order'
group by Adv_Type 

select Adv_type , count([Action]) as total_cnt
from Actions
group by Adv_Type

/*c.    Calculate Orders (Conversion) rates for each Advertisement Type 
by dividing by total count of actions casting as float by multiplying by 1.0.*/


select A.Adv_type, round( cast(A.cnt as float)/B.total_cnt, 2 ) as Conversion_Rate
from (
      select Adv_type , count([Action]) as cnt
      from Actions
      where [Action]= 'Order'
      group by Adv_Type) A,
	  (
	   select Adv_type , count([Action]) as total_cnt
       from Actions
       group by Adv_Type ) B
where A.Adv_Type= B.Adv_type
