create view disc_quantity as
select distinct product_id , discount,  
sum(quantity) over(partition by product_id, discount order by product_id, discount) as total_quantity
from sale.order_item;


select * from disc_quantity;


create view Discount as
with T1 as
(
select distinct product_id ,
FIRST_VALUE(total_quantity) over (partition by product_id order by product_id ) as first_quantity,
LAST_VALUE(total_quantity) over (partition by product_id order by product_id ) as last_quantity
from disc_quantity
)
select *, first_quantity-last_quantity as quantity_diff
from T1; 



select product_id, 
case  
     when  quantity_diff <0 then 'Negative'
	 when  quantity_diff =0 then 'Neutral'
	 when  quantity_diff >0 then 'Positive'
end as discount_effect
from Discount ;
