use sqltask_database;
CREATE TABLE monthly_finance (
    id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    month_name VARCHAR(20),
    sales DECIMAL(10,2),
    expenses DECIMAL(10,2),
    tax_rate DECIMAL(5,2)
);

INSERT INTO monthly_finance
VALUES
(101, 'Arjun', 'April', 72000.00, 41000.00, 12.00),
(102, 'Meera', 'April', 85000.00, 47000.00, 12.00),
(103, 'Kiran', 'April', 68000.00, 36000.00, 10.00),
(104, 'Arjun', 'May', 76000.00, 43000.00, 12.00),
(105, 'Meera', 'May', 91000.00, 51000.00, 12.00),
(106, 'Kiran', 'May', 73000.00, 39000.00, 10.00),
(107, 'Arjun', 'June', 81000.00, 45000.00, 12.00),
(108, 'Meera', 'June', 97000.00, 54000.00, 12.00),
(109, 'Kiran', 'June', 79000.00, 42000.00, 10.00);

select*from monthly_finance;


DELIMITER  //
create procedure calculatetax(
	in p_sales decimal(10.2),
    in p_tax_rate decimal(10,2)
    )
    
BEGIN
	select p_sales as sales,
    p_tax_rate as tax_rate,
    p_sales*p_tax_rate/100 as tax_amount;
END //
DELIMITER ;

call calculatetax(50000,3);
call calculatetax(22000,5);

create table month_end_closing(
month varchar(30),
total_sales decimal(10,2),
total_expenses decimal(10,2),
profit_lose decimal(10,2)
);

DELIMITER  //

create procedure month_end_closing(
in p_month varchar(20))
BEGIN
insert into month_end_closing (month,total_sales,total_expenses,profit_lose)
select month_name,sum(sales),sum(expenses),sum(sales)-sum(expenses)
from monthly_financeee
where month_name=p_month
group by month_name:

call month_end_closing('March');
call month_end_closing('February');
select*from month_end_closing;  


DELIMITER //
create procedure customersummary(
	in p_customer varchar(50)
)
BEGIN
	SELECT
		customer_name,
		sum(sales) as total_sales,
		sum(expenses) as total_expenses,
		sum(sales)-sum(expenses) as total_profit
	from monthly_financeee
    where customer_name=p_customer
    group by customer_name;
END //

DELIMITER ;
 
 call customersummary("Anu");
 call customersummary("priya"); 
 
 create table year_end_profit(
 total_sales varchar(40),
 total_expenses varchar(50),
 total_profit varchar(20)
 );

DELIMITER //

create procedure year_end_profit()
BEGIN
	insert into year_end_profit
    (total_sales,total_expenses,total_profit)
	select SUM(sales),SUM(expenses),SUM(sales) - SUM(expenses)
FROM monthly_financeee;

END //
DELIMITER ;

call year_end_profit();
select*from year_end_profit;