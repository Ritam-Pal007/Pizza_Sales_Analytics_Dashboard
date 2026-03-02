Create database pizza_db;
use pizza_db;

select * from pizza_sales;

ALTER TABLE pizza_sales
ADD OrderDate date;

set sql_safe_updates = 0; 

UPDATE pizza_sales SET OrderDate = STR_TO_DATE(order_date, '%d-%m-%Y');

alter table pizza_sales
drop order_date;

ALTER TABLE pizza_sales
ADD OrderTime time;

ALTER TABLE pizza_sales
drop order_time;

UPDATE pizza_sales SET OrderTime = STR_TO_DATE(order_time, '%H:%i:%s');


select sum(total_price) as Total_Revenue
from pizza_sales;

select sum(total_price)/count(distinct order_id) as avg_order_value
from pizza_sales; 

select sum(quantity) as Total_pizza_sold from pizza_sales;

select count(distinct order_id) as total_orders from pizza_sales;

select sum(quantity)/count(distinct order_id) as Avg_pizzas_per_order from pizza_sales;


-- Daily Trend
select dayname(OrderDate) as order_day, count(distinct order_id) as Total_orders
from pizza_sales
group by order_day; 

-- Hourly Trend
select Hour(OrderTime) as order_Time, count(distinct order_id) as Total_orders
from pizza_sales
group by Hour(OrderTime)
order by Hour(OrderTime);

-- Percentage of Sales by Pizza Category

select pizza_category, round(sum(total_price)*100/(select sum(total_price) from pizza_sales),2) as percentage_by_category
from pizza_sales
group by pizza_category;

-- Percentage of Sales by Pizza Size

select pizza_size, round(sum(total_price)*100/(select sum(total_price) from pizza_sales),2) as percentage_by_size
from pizza_sales
group by pizza_size
order by percentage_by_size desc;

-- Total pizza sold by Pizza category

select pizza_category, sum(quantity) as Pizza_sold_by_category
from pizza_sales
group by pizza_category;

-- Top 5 Best Seller

select pizza_name,sum(quantity) as Total_pizza_sold
from pizza_sales
group by pizza_name
order by Total_pizza_sold desc
limit 5;

 -- Bottom 5 Seller
 
 select pizza_name,sum(quantity) as Total_pizza_sold
from pizza_sales
group by pizza_name
order by Total_pizza_sold asc
limit 5;