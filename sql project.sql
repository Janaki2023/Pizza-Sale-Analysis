create database pizzaorder;
use pizzaorder;
show tables;
select * from pizzaplace;
#deleting the unknown column from the data
alter table pizzaplace
drop column myunknowncolumn;
select * from pizzaplace;
#checking for null values
select * from pizzaplace
where id is null;
#Business Questions Answered

#Q1.Highest Sales based on size of the pizza
SELECT * FROM PIZZAPLACE;
SELECT size,round(sum(price)) AS Total_Price from pizzaplace
group by size order by sum(price) desc;
#Inference L size pizza earned the highest.

#Q2.Highest Selling pizza category

select type,round(sum(price)) AS Total_Price from pizzaplace
group by type order by sum(price) desc;
#Inference Classic type of pizza earned the highest.

#Q3.Top 10 Selling Pizza name
select name,round(sum(price)) as Total_price from pizzaplace
group by name order by sum(price) desc limit 10;
#Inference : Thai chicken is the highest selling pizza and other 10 pizza types are listed.

 #Q4. Sales by Day of Week
 select * from pizzaplace;
 select dayname(date) as Day_name, round(sum(price)) as Total_sales from pizzaplace
 group by dayname(date) order by sum(price) desc;
 #Inference: Friday had the highest sales
 
 #Q5.count of orderS
select count(id) as totalorders,monthname(date) as month from pizzaplace
group by month order by totalorders desc;
#Inference: July has the highest orders.
 
 #Q6.top Selling hour of the day
select hour(time) as hour_of_the_day ,count(id) as pizzacount
from pizzaplace 
group by hour_of_the_day order by pizzacount desc;
 #Q7.Sales By Month
 select monthname(date) as Month,round(sum(price)) from pizzaplace
 group by monthname(Date) order by round(sum(price)) desc;
 
 #Inference July has the highest sales.
 
#Q8.Average Monthly Sales and Month higher than Average Sales

WITH monthly_sales AS
     (SELECT month(date) as months,
       round(sum(price))as Sales
       FROM pizzaplace
       GROUP BY months)
SELECT *
FROM monthly_sales m
JOIN(SELECT avg(Sales) AS Avg_Sales 
     FROM monthly_sales)a
 on m.sales> a.Avg_Sales; 
 #Inference: 8 months did more than the average monthly sale of 68,155.

#Q9.Percentage increase of sales 
 WITH monthly_sales as
      (SELECT month(date) as months, round(sum(price))as Sales
       FROM pizzaplace
       GROUP BY months)
 SELECT *,
    Lag(Sales) OVER(ORDER BY months) AS Previous_Month_Sales,
    Sales-Lag(Sales) OVER(ORDER BY months) AS Monthly_Sales_Difference,
    round((Sales-Lag(Sales) OVER(ORDER BY months))/(Lag(Sales) OVER(ORDER BY months))*100,2) As Percent_monthly_increase
 FROM monthly_sales;   
 
