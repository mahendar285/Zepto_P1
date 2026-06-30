 -- Q1) How many products are available in the inventory?
select COUNT(*) as Total_Products from Zepto_P1;
-- Q2: How many unique product categories are available in the Zepto inventory?
select Count(distinct Category)  as Unique_Product from Zepto_P1;
-- Q3: Show all unique product categories available in the inventory.
select distinct Category from Zepto_P1
-- Q4: How many products are available in each category?
select Category, COUNT(*) as Products_Count from Zepto_P1
group by Category
order by COUNT(*) asc;
-- Q5: Which 10 products have the highest MRP (Maximum Retail Price)?
select top 10 name ,mrp from Zepto_P1
order by mrp desc;
-- Q6: Which 10 products have the lowest MRP?
select top 10 name,mrp from Zepto_P1
order by mrp asc;
-- Q7: What is the average MRP (Maximum Retail Price) of all products?
select AVG(mrp) as Avg_Mrp from Zepto_P1;
-- Q8: What is the highest and lowest MRP among all products?
select MAX(mrp) as max_mrp,MIN(mrp) as min_mrp from Zepto_P1;
-- Q9: What is the average discount percentage offered across all products?
select AVG(discountPercent) as Avg_per from Zepto_P1
-- Q10: Which 10 products have the highest discount percentage?
select top 10 name, discountpercent from Zepto_P1
order by discountpercent desc;
-- Q11: Which categories offer the highest average discount percentage?
select top 1 category ,avg(discountpercent) as high_avg from Zepto_P1
group by category
order by high_avg desc;
-- Q12: Which 10 products have the highest discounted selling price?
select top 10 name, discountedSellingPrice from Zepto_P1
order by discountedSellingPrice desc;
-- Q13: How many products are currently out of stock?
select count(name) as outodstack_products from Zepto_P1
where outOfStock=1
-- Q14: How many out-of-stock products are there in each category?
select COUNT(name) as product_count,category from Zepto_P1
where outofstock=1
group by Category
order by product_count asc;
-- Q15: Which category has the highest number of out-of-stock products?
select top 1 COUNT(outOfStock) as highest_outofstack ,category from Zepto_P1
where outOfStock=1
group by Category
order by COUNT(outOfStock) desc;
-- Q16: What is the total inventory value?
select sum(discountedSellingPrice*availableQuantity) as total_ProductInventary from zepto_p1
-- Q17: What is the average available quantity of products in inventory?
select AVG(availableQuantity) from Zepto_P1
-- Q18: Which category has the highest average available quantity?
select top 1 category,avg(availableQuantity) from Zepto_P1
group by Category
order by AVG(availableQuantity) desc;
-- Q19: What is the total available quantity of all products in inventory?
select sum(availablequantity) from  Zepto_P1
-- Q20: Which 10 products have the highest available quantity in stock?
select top 10 name,availablequantity from Zepto_P1
order by availablequantity desc;
-- Q21: Which category has the highest total available quantity?
select top 1 Category, max(availablequantity) as max_avaliblequantity from Zepto_P1
group by Category
order by max_avaliblequantity desc;
-- Q22: Which category has the lowest total available quantity?
select top 10 category,sum(availablequantity) as sum_avaliblequantity from Zepto_P1
group by Category
order by sum(availableQuantity) asc;
--Q23: Which category has the highest average discount percentage?
select top 1 Category,AVG(discountPercent) as avg_dispersentage from Zepto_P1
group by category
order by avg_dispersentage desc;
-- Q24: Which category has the lowest average discount percentage?
select top 1 category,avg(discountpercent) as sum_dispercent from Zepto_P1
group by Category
order by sum_dispercent asc
-- Q25: Which category has the highest average MRP?
select top 1 category,AVG(mrp) as highest_avgmrp from Zepto_P1
group by Category
order by highest_avgmrp desc;
-- Q26: Which categories have more than 100 products?
select category,COUNT(*) as products from Zepto_P1
group by Category
having COUNT(*)>100;
-- Q27: Which categories have an average MRP greater than 500?
select category,AVG(mrp) as avg_mrp from Zepto_P1
group by Category
having AVG(mrp)>500;
-- Q28: Which categories have a total available quantity greater than 10,000?
select category,SUM(availablequantity) as sum_totalaq from Zepto_P1
group by Category
having SUM(availablequantity)>10000;
-- Q29: Which categories have more than 100 products AND an average MRP greater than 500?
select category,COUNT(*),AVG(mrp) from Zepto_P1
group by Category
having COUNT(*)>100 and AVG(mrp)>500;
-- Q30: Which categories have fewer than 50 products OR an average discount percentage greater than 20?
select category,COUNT(*),AVG(discountPercent) from Zepto_P1
group by Category
having COUNT(*)<50 or avg(discountpercent) >20;
-- Q31 Which 10 products have the highest inventory value?
select top 10 name,discountedSellingPrice*availableQuantity as highst_inventary from Zepto_P1
order by highst_inventary desc;
-- Q32 Which category contributes the highest total inventory value?
select top 1 category,SUM(discountedSellingPrice*availableQuantity) from zepto_p1
group by Category
order by SUM(discountedSellingPrice*availableQuantity) desc;
-- Q33 Show the top 5 categories by total inventory value.
select top 5 category,SUM(discountedSellingPrice*availableQuantity) as top_values from Zepto_P1
group by Category
order by top_values desc;
-- Q34 Which products have an MRP greater than the overall average MRP?
select name,mrp as avg_mrp from Zepto_P1
where mrp >
(select AVG(mrp) from Zepto_P1);
-- Q35 Which products have a discount percentage greater than the overall average discount percentage?
select name as product,discountPercent as avg_discountPercent from Zepto_P1
where discountPercent >
(Select avg(discountPercent) from Zepto_P1);
-- Q36 Which products have an available quantity greater than the overall average available quantity?
select name, availableQuantity from Zepto_P1
where availableQuantity >
(select AVG(availableQuantity) as avg_availableQuantity from Zepto_P1);
-- Q37 Show all products ranked by MRP from highest to lowest.
select name,mrp ,dense_rank() over(order by mrp desc) as rnk from Zepto_P1
-- Q38 Find the Top 5 most expensive products using DENSE_RANK().
select *
from(
select name,discountedSellingPrice, dense_rank() over(order by discountedSellingPrice desc) as rnk from Zepto_P1
) t
where rnk <= 5;
-- Q39 Rank products within each category based on MRP.
select * from
( select category,name,RANK() over(PARTITION by category order by mrp desc) as rnk from Zepto_P1) t
-- Q40 Find the most expensive product in each category.
select *
from(
select name,category ,dense_rank() over(partition by category order by mrp DESC) AS rnk from zepto_p1) t
where rnk=1;
-- Q41 Find the least expensive product in each category.
select *
from(
select name,category ,dense_rank() over(partition by category order by mrp asC) AS rnk from zepto_p1) t
where rnk=1;
-- Q42 Find the Top 3 most expensive products in each category.
select *
from(
select name,category ,dense_rank() over(partition by category order by mrp desc) AS rnk from zepto_p1) t
where rnk<=3;
-- Q43 Which categories have a total inventory value greater than the average inventory value across all categories?
select category,SUM(discountedSellingPrice*availableQuantity) from Zepto_P1
group by Category
having SUM(discountedSellingPrice*availableQuantity) > 
(select AVG(SUM_VALUE) from 
(
select  SUM(discountedSellingPrice*availableQuantity) as SUM_VALUE from Zepto_P1
group by Category
) t
);
-- Q44 Which products have the highest discount percentage within their category?
select *
from(
select name, category ,discountpercent, dense_rank() over(partition by category order by discountpercent desc ) as rnk
from Zepto_P1) t
where rnk<=1
-- Q45 Which categories have an average discount percentage above the overall average discount percentage?
select category,avg(discountPercent) from Zepto_P1
group by Category
having AVG(discountpercent) >
(select avg(discountPercent) from Zepto_P1)
-- Q46 Categorize products based on MRP using CASE WHEN.
select name,mrp,
case
when mrp>1000 then 'Expensive'
when mrp>=500 then 'medium'
else 'cheap'
end as price_category
from zepto_p1;
-- Q47 How many products belong to each Price_Category (Expensive, Medium, Cheap)?
select
case
when mrp>1000 then 'expensive'
when mrp>=500 then 'medium'
else 'cheap'
end as price_category,
count(*) as total_products from zepto_p1
group by 
case
when mrp>1000 then 'expensive'
when mrp>=500 then 'medium'
else 'cheap'
end;
-- Q48 Find the percentage of products in each Price_Category (Expensive, Medium, Cheap).
select
case
when mrp>1000 then 'expensive'
when mrp>=500 then 'medium'
else 'cheap'
end as price_category,
COUNT(*) AS Total_Products,
COUNT(*) * 100.0 / 
(SELECT COUNT(*) FROM Zepto_P1) AS Percentage
FROM Zepto_P1
group by 
case
when mrp>1000 then 'expensive'
when mrp>=500 then 'medium'
else 'cheap'
end;
-- Q49 Find the total inventory value for each Price_Category (Expensive, Medium, Cheap).
select
case
when mrp>1000 then 'expensive'
when mrp>=500 then 'medium'
else 'cheap'
end as price_category,
sum(discountedSellingPrice*availableQuantity) as_total_inventary from Zepto_P1
group by 
case
when mrp>1000 then 'expensive'
when mrp>=500 then 'medium'
else 'cheap'
end;
-- Q50 Which Risk Category contains the highest number of products?
SELECT
case
when outOfStock=1 then 'High Risk'
when availableQuantity<20 then 'medium risk'
else 'Low Risk'
end as Risk_Category,
count(*) as Product_count
from Zepto_P1
group by
case
when outOfStock=1 then 'High Risk'
when availableQuantity<20 then 'medium risk'
else 'Low Risk'
end
-- Q51 Show the following for each Category in a single query:
-- Total Products
-- In Stock Products
-- Out of Stock Products
select
sum(
case
when outOfStock = 0 then 1
else 0
end )as instack_product,
sum(
case
when outOfStock = 1 then 1
else 0
end) as outofstack_product,
count(*) as total_products
from Zepto_P1
group by Category;
-- Q52 Show the following metrics for each Category in a single query:
--Total Inventory Value
--High Discount Inventory Value (discountPercent >= 30)
--Low Discount Inventory Value (discountPercent < 30)
select
count(discountedSellingPrice*availableQuantity),
sum(
case
when discountPercent>=30 then discountedSellingPrice*availableQuantity
else 0
end),
sum(
case
when discountPercent<30 then discountedSellingPrice*availableQuantity
else 0
end) from Zepto_P1
group by Category;
-- Q53 Show the following metrics for each Category in a single query:
--Premium Products Count (MRP > 1000)
--Medium Products Count (MRP BETWEEN 500 AND 1000)
--Budget Products Count (MRP < 500)
select category,
sum(case
when mrp>1000 then 1
else 0
end) as Premium_Products,
sum(case
when mrp Between 500 and 1000 then 1
else 0
end) as Medium_Products,
sum(case
when mrp<500 then 1
else 0
end) as Budget_Products
from Zepto_P1
group by category;
-- Q54 Calculate the inventory value lost because of Out of Stock products.
select
SUM(case
when outOfStock=1 then discountedSellingPrice*availableQuantity
else 0
end) from Zepto_P1
-- Q55 create a Category Health Report showing:
--Category
--Total Products
--Average Discount Percentage
--Total Inventory Value
--Out Of Stock Products
select category,COUNT(*),AVG(discountPercent),
SUM(discountedSellingPrice*availableQuantity) ,
sum(case
when outOfStock =1 then 1
else 0
end)
from Zepto_P1
group by Category;
-- Q56 Find categories whose average discount percentage is greater than the overall average discount percentage.
select category,avg(discountPercent)from Zepto_P1
group by Category
having AVG(discountPercent) >
(select AVG(discountPercent) from Zepto_P1)
-- Q57 Find categories whose Total Inventory Value is greater than the Average Category Inventory Value.
select category,
sum(discountedSellingPrice*availableQuantity) from Zepto_P1
group by Category
having sum(discountedSellingPrice*availableQuantity) > 
(select AVG(Total_Value) 
from(
select sum(discountedSellingPrice*availableQuantity) as Total_Value from Zepto_P1
group by Category
) t
);
-- Q58 Find the Top 5 Categories by Total Inventory Value.
select top 5 category, sum(discountedSellingPrice*availableQuantity) from Zepto_P1
group by Category
Order by COUNT(discountedSellingPrice*availableQuantity) desc;
-- Q59 Find the Top 5 Categories by Average Discount Percentage.
select top 5 category, AVG(discountpercent) from Zepto_P1
group by Category
order by AVG(discountPercent) desc;
-- Q60 Find the Top 5 Categories by Total Available Quantity.
select top 5 category, sum(availableQuantity) from Zepto_P1
group by Category
order by SUM(availableQuantity) desc;
-- Q61 Find products whose MRP is greater than the average MRP of their own category.
SELECT name,category,mrp from Zepto_P1 p1
where mrp>
(select AVG(mrp) from Zepto_P1 p2
where p1.Category=p2.Category)
-- Q62 Find products whose Discount Percentage is greater than the average Discount Percentage of their own category.
select name,discountPercent from Zepto_P1 p1
where discountPercent >
(select AVG(discountPercent) from Zepto_P1 p2
where p1.Category=p2.Category);
-- Q63 Find products whose Available Quantity is greater than the average Available Quantity of their own category.
select name,availableQuantity from Zepto_P1 p1
where availableQuantity >
(select AVG(availableQuantity) from Zepto_P1 p2
where p1.Category=p2.Category);
-- Q64 Q64 – Find the most expensive product in each category.
select *
from (
select name,category,discountedSellingPrice,
DENSE_RANK() over(partition by category order by mrp desc) rnk
from Zepto_P1) t
where rnk=1;
-- Q65 Find the cheapest product in each category.
select *
from (
select name,category,discountedSellingPrice,
DENSE_RANK() over(partition by category order by mrp asc) rnk
from Zepto_P1) t
where rnk=1;
-- Q66 Find the Top 3 most expensive products in each category.
select *
from (
select name,category,discountedSellingPrice,
DENSE_RANK() over(partition by category order by mrp
 desc) rnk
from Zepto_P1) t
where rnk<=3;
-- Q67 Find the Top 3 products with the highest discount percentage in each category.
select *
from (
select name,category,discountpercent,
DENSE_RANK() over(partition by category order by discountpercent
 desc) rnk
from Zepto_P1) t
where rnk<=3;
-- Q68 Find the product with the highest Inventory Value in each category.
select *
from (
select name,category,discountedSellingPrice * availableQuantity AS Inventory_Value,
DENSE_RANK() over(partition by category order by discountedSellingPrice*availableQuantity
 desc) rnk
from Zepto_P1) as t
where rnk=1;
-- Q69 Find the category that contributes the maximum Total Inventory Value.
select top 1 category,sum(discountedSellingPrice * availableQuantity) from Zepto_P1
group by Category
order by sum(discountedSellingPrice * availableQuantity) desc;
-- Q70 Find the category that has the maximum number of products.
select top 1 category ,count(*) from Zepto_P1
group by Category
order by COUNT(*) desc;
-- Q71 Find the second most expensive product in each category.
select *
from( select name, category,mrp,DENSE_RANK() over(partition by category order by mrp desc) rnk from Zepto_P1
) t
where rnk=2;
-- Q72 Find the third most expensive product in each category.
select *
from( select name, category,mrp,DENSE_RANK() over(partition by category order by mrp desc) rnk from Zepto_P1
) t
where rnk=3;
-- Q73 Find all products that have the same MRP as another product.
select name,category
,mrp from Zepto_P1
where mrp IN
(select mrp from Zepto_P1
group by mrp
having COUNT(*) >1);
-- Q74 Find all categories that have more than 100 products.
select category,COUNT(*) from Zepto_P1
group by Category
having COUNT(*)>100
-- Q75 Find all categories whose average MRP is greater than 500.
select category ,AVG(mrp) from Zepto_P1
group by Category
having AVG(mrp)>500;
-- Q76 Find all categories whose Total Inventory Value is greater than 1,000,000.
select category,SUM(discountedSellingPrice*availableQuantity) from Zepto_P1
group by Category
having SUM(discountedSellingPrice*availableQuantity) > 1000000;
-- Q77 Find the category that has the lowest Total Inventory Value.
select top 1 category ,SUM(discountedSellingPrice*availableQuantity) from Zepto_P1
group by Category
order by SUM(discountedSellingPrice*availableQuantity) asc;
-- Q78 Find the top-selling product (highest Inventory Value) in each category, but only show categories 
--where the Total Inventory Value is greater than 1,000,000.
select * from(
select category ,name,discountedSellingPrice*availableQuantity as total_inventary,
DENSE_RANK() over(PARTITION by category order by discountedSellingPrice*availableQuantity desc) rnk from Zepto_P1) t
where rnk =1 and category in 
(select category from Zepto_P1
group by Category
having SUM(discountedSellingPrice*availableQuantity)>
1000000);
-- Q79 Find products whose Inventory Value is greater than the average Inventory Value of all product.
select name,category,discountedSellingPrice*availableQuantity from Zepto_P1
where discountedSellingPrice*availableQuantity >(
select AVG(discountedSellingPrice*availableQuantity) from Zepto_P1)
-- Q80 Generate a Category Performance Report showing:
--Category
--Total Products
--In-Stock Products
--Out-of-Stock Products
--Average MRP
--Average Discount Percentage
--Total Inventory Value
select category,count(*),avg(mrp),avg(discountpercent),sum(discountedSellingPrice*availableQuantity),
sum(case
when outOfStock =1 then 1
else 0 end) as outofstack,
sum(Case when outOfStock=0 then 1
else 0 end) as instack
from Zepto_P1
group by Category;
-- Q81 Using a CTE, find the most expensive product in each category.
with expensive_product as
(
select name,category,mrp ,dense_rank() over(partition by category order by mrp desc) as rnk from Zepto_P1)
select*from expensive_product
where rnk=1;
-- Q82 Using a CTE,FIND THE TOP 3 MOST EXPENSIVE PRODUCTS IN EACH CATEGORY.
with top_products as
(select name,
category,mrp,
DENSE_RANK() over(PARTITION by category order by mrp desc) rnk from Zepto_P1
)
select * from top_products
where rnk<=3
order by Category, rnk;
-- Q82 Using a CTE, find the second most expensive product in each category.
with second_mostexpensive as
(select name,category,mrp,DENSE_RANK() over(PARTITION BY category order by mrp desc) as rnk from Zepto_P1
) 
select * from second_mostexpensive
where rnk=2;
-- Q84 Using a CTE, find the products whose MRP is greater than the average MRP of the entire dataset.
with avg_mrp as
(select name ,mrp,Category from Zepto_P1
where mrp>
(select AVG(mrp) as avg_mrps from Zepto_P1)
)
select * from avg_mrp;
-- Q85 Using multiple CTEs, find the category with the highest total inventory value.
;WITH inventory_value AS
(
SELECT
category,SUM(discountedSellingPrice * availableQuantity) AS total_inventory
FROM Zepto_P1
GROUP BY category
),
ranked_category AS
(
SELECT
category,
total_inventory,
DENSE_RANK() OVER(ORDER BY total_inventory DESC) AS rnk
FROM inventory_value
)

SELECT
category,
total_inventory
FROM ranked_category
WHERE rnk = 1;