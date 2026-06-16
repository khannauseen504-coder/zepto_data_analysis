create database zepto;
use zepto;
create table zepto(
sku_id serial primary key,
category varchar (150),
name varchar(150) not null,
mrp numeric(8,2),
discountPercent numeric(5,2),
availableQuantity int,
discountedSellingPrice numeric(8,2),
weightInGms int,
outOfStock boolean,
quantity int
);
truncate table zepto;
drop table zepto;
select * from zepto limit 10;

Alter table zepto_v2
add column sku_id serial Primary Key;

Alter table zepto_v2 rename to zepto;

/* data explore*/

select * from zepto;
/* count rows*/
select  count(*) from zepto;
/*  count category*/
select count(distinct category) from zepto;

/* select through id*/
select *
from zepto
where sku_id=3725;

/* check any null value */
select * from zepto
where name is null or
Category is null or
mrp is null or
discountPercent is null or
availableQuantity is null or
discountedSellingPrice is null or
weightInGms is null or
outOfStock is null or
quantity is null;
 
 /* explore category*/
select distinct category 
from zepto 
order by category;

/* product by stock*/
SELECT 
    outOfStock, COUNT(sku_id)
FROM
    zepto
GROUP BY outOfStock;

/* product appear more then 1 time*/
select name, count(sku_id) from zepto 
group by name 
having count(sku_id) >1 
order by count(sku_id) Desc;

/* data cleaning */

/* products with price 0*/
select * 
from zepto
where mrp=0;

delete from zepto where mrp=0;
/* convert paise to rupees*/
Update zepto 
set mrp = mrp/100.0,
discountedSellingPrice=discountedSellingPrice/100.0;
select * from zepto limit 10;

/* top 10 best value products based on discount percentage*/
SELECT 
    distinct NAME , MRP, discountPercent
FROM
    zepto
ORDER BY discountPercent DESC
LIMIT 10;

/* products with high mrp BUT OUT OF STOCK */

SELECT distinct NAME ,MRP from zepto where outofstock= true and mrp >300 order by mrp desc;

/* Estimated revenue for each category */
SELECT 
    Category,
    SUM(discountedSellingPrice * availableQuantity) AS Revenue
FROM
    zepto
GROUP BY Category
ORDER BY Revenue DESC;

/* all products where mrp is greater than 500rs and discount is less than 10%*/
SELECT 
    name, mrp, discountPercent
FROM
    zepto
WHERE
    mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC;

/* top 5 category offering the highest average discount*/
SELECT 
    Category, ROUND(AVG(discountPercent), 2) AS avgdiscount
FROM
    zepto
GROUP BY Category
ORDER BY avgdiscount DESC
LIMIT 5;

/* the price per gram for products above 100g and sort by best value */ 
SELECT DISTINCT
    name,
    discountedSellingPrice,
    weightInGms,
    ROUND(discountedSellingPrice / weightInGms, 2) AS pricepergrm
FROM
    zepto
WHERE
    weightInGms >= 100
ORDER BY pricepergrm DESC;

/*  group the products into category like low ,medium,bulk*/
SELECT DISTINCT
    name,
    weightInGms,
    CASE
        WHEN weightInGms <= 1000 THEN 'low'
        WHEN weightInGms <= 5000 THEN 'medium'
        ELSE 'bulk'
    END AS weightcategory
FROM
    zepto;

/* total inventory weight per category*/
select  Category ,sum(weightInGms * availableQuantity) as totalweight from zepto group by Category order by totalweight desc;
