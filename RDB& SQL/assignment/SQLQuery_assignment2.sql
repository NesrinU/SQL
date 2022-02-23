select * from product.product

select product_id, product_name
from product.product
where product_name= '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'


select  a.customer_id, a.first_name, a.last_name, 




select a.customer_id, a.first_name, a.last_name
from sale.customer as a
join sale.orders as b
on a.customer_id= b.customer_id
join sale.order_item as c
on b.order_id= c.order_id
join product.product as d
on c.product_id= d.product_id
where d.product_name= '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'







select  x.customer_id, x.first_name, x.last_name  , 
ISNULL(NULLIF(ISNULL(y.first_name, 'NO'),y.first_name),'YES') as First_product,
ISNULL(NULLIF(ISNULL(z.first_name, 'NO'),z.first_name),'YES')  as Second_product,
ISNULL(NULLIF(ISNULL(t.first_name, 'NO'),t.first_name),'YES') as Third_product
from 
(
select  d.customer_id, d.first_name, d.last_name
from product.product a, sale.order_item b, sale.orders c, sale.customer d
where a.product_id= b.product_id
and b.order_id= c.order_id
and c.customer_id= d.customer_id
and a.product_name= '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'
) x
left join 
(
select  d.customer_id, d.first_name, d.last_name
from product.product a, sale.order_item b, sale.orders c, sale.customer d
where a.product_id= b.product_id
and b.order_id= c.order_id
and c.customer_id= d.customer_id
and a.product_name= 'Polk Audio - 50 W Woofer - Black'
) y
on y.customer_id= x.customer_id
left join 
(
select  d.customer_id, d.first_name, d.last_name
from product.product a, sale.order_item b, sale.orders c, sale.customer d
where a.product_id= b.product_id
and b.order_id= c.order_id
and c.customer_id= d.customer_id
and a.product_name= 'SB-2000 12 500W Subwoofer (Piano Gloss Black)'
) z
on x.customer_id= z.customer_id

left join 
(
select  d.customer_id, d.first_name, d.last_name
from product.product a, sale.order_item b, sale.orders c, sale.customer d
where a.product_id= b.product_id
and b.order_id= c.order_id
and c.customer_id= d.customer_id
and a.product_name='Virtually Invisible 891 In-Wall Speakers (Pair)'
) t
on x.customer_id= t.customer_id

order by x.customer_id 