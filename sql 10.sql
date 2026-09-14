use sqltask_database;
CREATE TABLE monthly_sales (
    sale_month DATE,
    customer_name VARCHAR(50),
    sales DECIMAL(12,2)
);

INSERT INTO monthly_sales (sale_month, customer_name, sales)
VALUES
('2023-01-01', 'Rahul', 125000),
('2023-02-01', 'Sneha', 138000),
('2023-03-01', 'Kiran', 145000),
('2023-04-01', 'Meera', 152000),
('2023-05-01', 'Rohan', 160000),
('2023-06-01', 'Anjali', 147000),
('2023-07-01', 'Vikram', 172000),
('2023-08-01', 'Pooja', 158000),
('2023-09-01', 'Nikhil', 181000),
('2023-10-01', 'Divya', 169000),
('2023-11-01', 'Amit', 176000),
('2023-12-01', 'Neha', 185000),

('2024-01-01', 'Rahul', 190000),
('2024-02-01', 'Sneha', 178000),
('2024-03-01', 'Kiran', 195000),
('2024-04-01', 'Meera', 187000),
('2024-05-01', 'Rohan', 205000),
('2024-06-01', 'Anjali', 198000),
('2024-07-01', 'Vikram', 215000),
('2024-08-01', 'Pooja', 208000),
('2024-09-01', 'Nikhil', 225000),
('2024-10-01', 'Divya', 218000),
('2024-11-01', 'Amit', 230000),
('2024-12-01', 'Neha', 240000);

SELECT * FROM monthly_sales;

select sale_month,customer_name, sales,
      rank() over(order by sales desc) as sales_rank
from monthly_sales;

select sale_month,customer_name, sales,
 dense_rank() over (order by sales desc) as sales_rank from monthly_sales;      
 
 select sale_month,customer_name, sales,
  row_number() over (order by sales desc) as row_number_of_sales from monthly_sales; 
 
 select sale month,customer_name, sales, 
lag(sales) over (order by sale_month) as previous_month_sales from monthly_sales; 

select sale_month, customer_name, sales,
  lead(sales) over (order by sale_month) as next_month_sales from monthly_sales; 

select sale_month,customer_name, sales, 
 lag(sales, 12) over (order by sale_month) as previous_year_sales from monthly_sales; 

select sale_month, customer_name, sales,
 lead(sales, 12) over (order by sale_month) as next_year_sales from monthly_sales;

select sale month, sales, sum(sales) over (order by sale_month) as running_total from monthly_sales; 

select sale_month, sales, lag(sales, 12) over (order by sale_month) as previous_year_sales,
 ((sales-lag(sales, 12) over (order by sale_month))/lag(sales, 12) over (order by sale_month))*100 as yoy_growth
 from monthly_sales;
 
 select sale_month,customer_name, sales,
rank() over(order by sales desc) as sales_rank,
dense_rank() over(order by sales desc) as sales_dense_rank,
row_number() over(order by sales desc) as sales_row_number,
lag(sales) over (order by sale_month) as previous_month_sales,
lead(sales) over (order by sale_month) as next_month_sales
 from monthly_sales;

