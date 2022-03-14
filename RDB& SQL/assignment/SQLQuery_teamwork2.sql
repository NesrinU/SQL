--Q1: By using view get the average sales by staffs and years using the AVG() aggregate function?
--VIEW kullanarak, AVG() toplama işlevini kullanarak personele ve yıllara göre ortalama satışları elde edin?
create view avg_sale_staff_year as
(
select a.first_name, a.last_name, datepart(year, b.order_date ) as [year], 
avg(c.list_price*c.quantity) as avg_per_year
from sale.staff a, sale.orders b, sale.order_item c
where a.staff_id= b.staff_id
and b.order_id= c.order_id
group by a.first_name, a.last_name, datepart(year, b.order_date )
)

select *
from avg_sale_staff_year
order by 1,2,3

select distinct a.first_name, a.last_name, datepart(year, b.order_date ) as [year], 
avg(c.list_price*c.quantity) over(partition by a.first_name, a.last_name, datepart(year, b.order_date )) as avg_per_year
from sale.staff a, sale.orders b, sale.order_item c
where a.staff_id= b.staff_id
and b.order_id= c.order_id

CREATE VIEW Weekly_Agenda_8_1 ASSELECT	first_name, last_name, year, avg_amountFROM	(	SELECT	A.first_name, A.last_name, 		YEAR(B.order_date) AS year, 		AVG(C.quantity * C.list_price) AS avg_amount	FROM	sale.staff A, sale.orders B, sale.order_item C	WHERE	A.staff_id = B.staff_id AND				B.order_id = C.order_id	GROUP BY A.first_name, A.last_name, YEAR(B.order_date)	) A;SELECT *FROM Weekly_Agenda_8_1ORDER BY first_name, last_name, year--alternativeSELECT s.first_name, s.last_name, YEAR(o.order_date) AS year, AVG((i.list_price-i.discount)*i.quantity) AS avg_amountFROM sales.staffs sINNER JOIN sales.orders oON s.staff_id=o.staff_idINNER JOIN sales.order_items iON o.order_id=i.order_idGROUP BY s.first_name, s.last_name, YEAR(o.order_date)ORDER BY first_name, last_name, YEAR(o.order_date)


--Q2: Select the annual amount of product produced according to brands (use window functions).

select distinct b.brand_name, a.model_year, 
count(a.product_id) over(partition by  b.brand_name, a.model_year)
from product.product a, product.brand b
where a.brand_id= b.brand_id

------
SELECT DISTINCT B.brand_name, P.model_year,	COUNT(P.[product_id]) OVER (PARTITION BY  B.brand_name, P.model_year) AS annual_amount_brandsFROM [product].[brand] B	INNER JOIN [product].[product] P	ON B.brand_id = P.brand_idORDER BY B.brand_name, P.model_year



--Q3: Select the least 3 products in stock according to stores.
with cte as
(
select a.store_name, b.product_name,
sum(c.quantity) over(partition by a.store_name, b.product_name ) as quant
from sale.store a, product.product b, product.stock c
where a.store_id= c.store_id
and b.product_id= c.product_id
)
select *, 
rank() over(partition by store_name, product_name, quant order by quant)
from cte 
where quant > 0
order by store_name, quant asc

------

SELECT A.store_name, C.product_name, SUM(B.quantity) product_quantityFROM sale.store A, product.stock B, product.product CWHERE A.store_id  = B.store_idAND B.product_id = C.product_idGROUP BY A.store_name, C.product_nameHAVING SUM(B.quantity) > 0ORDER BY 1,2,3

SELECT *FROM (		SELECT A.store_name, C.product_name, SUM(B.quantity) product_quantity,				ROW_NUMBER() OVER(PARTITION BY A.store_name ORDER BY SUM(B.quantity)) least_3		FROM sale.store A, product.stock B, product.product C		WHERE A.store_id  = B.store_id		AND B.product_id = C.product_id		GROUP BY A.store_name, C.product_name		HAVING SUM(B.quantity) > 0		) AWHERE A.least_3 <= 3

------
SELECT	*FROM	(		SELECT ss.store_name, p.product_name, SUM(s.quantity) product_quantity,		ROW_NUMBER() OVER(PARTITION BY ss.store_name ORDER BY SUM(s.quantity) ASC) least_3		FROM [sale].[store] ss			INNER JOIN [product].[stock] s			ON ss.store_id=s.store_id			INNER JOIN [product].[product] p			ON s.product_id=p.product_id		GROUP BY ss.store_name, p.product_name		HAVING SUM(s.quantity) > 0		) AWHERE	A.least_3 < 4--alternative;WITH temp_cteAS(SELECT ss.[store_name], pp.[product_name],ROW_NUMBER() OVER(PARTITION BY ss.[store_name] ORDER BY ss.[store_name]) AS [row number]FROM [product].[product] ppINNER JOIN [product].[stock] pson pp.product_id = ps.product_idINNER JOIN [sale].[store] ssON ps.store_id = ss.store_id)SELECT * FROM temp_cteWHERE [row number] < 4


--Q4: Return the average number of sales orders in 2020 sales.(for each staff)

SELECT staff_id, COUNT(order_id) num_salesFROM sale.ordersWHERE order_date LIKE '2020%' -- YEAR(order_date)=2020 GROUP BY staff_id

WITH new_sales AS(	SELECT staff_id, COUNT(order_id) num_sales	FROM sale.orders	WHERE order_date LIKE '2020%'   	GROUP BY staff_id)SELECT AVG(num_sales) 'Average Number of Sales' FROM new_sales



------SELECT AVG(A.sales_amounts) AS 'Average Number of Sales'FROM (    SELECT COUNT(order_id) sales_amounts    FROM sale.orders    WHERE order_date LIKE '%2020%'     GROUP BY staff_id    ) as A--alternativeSELECT COUNT(order_id) AS Count_of_SalesINTO Total_Orders_2017FROM sale.ordersWHERE YEAR(order_date) = 2020;SELECT COUNT(first_name) AS Count_of_StaffsINTO Staffs_Sold_2020FROM sale.staffWHERE staff_id IN (				SELECT staff_id				FROM sale.orders				WHERE YEAR(order_date) = 2020);SELECT A.Count_of_Sales / B.Count_of_Staffs AS 'Average Number of Sales'FROM Total_Orders_2017 A, Staffs_Sold_2020 B;--alternativeWITH cte_avg_sale AS(	SELECT staff_id, COUNT(order_id) as sales_count	FROM sale.orders	WHERE YEAR(order_date)=2020	GROUP BY staff_id	)SELECT AVG(sales_count) as 'Average Number of Sales'FROM cte_avg_sale





--Q5: Assign a rank to each product by list price in each brand and get products with rank less than or equal to three.

with cte as
(
select product_id , product_name, brand_id, list_price,
rank() over(partition by brand_id order by list_price desc ) as ranking 
from product.product 
)
select *
from cte
where ranking <= 3


-----SELECT * FROM (				SELECT					product_id,					product_name,					brand_id,					list_price,					RANK () OVER ( 						PARTITION BY brand_id						ORDER BY list_price DESC					) price_rank 				FROM					product.product			) tWHERE price_rank <= 3;
