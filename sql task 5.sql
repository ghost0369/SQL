use my_database;
CREATE TABLE journal_entrie(
    entry_id INT PRIMARY KEY,
    entry_date DATE,
    account_name VARCHAR(255),
    description VARCHAR(255),
    debit DECIMAL(10, 2),
    credit DECIMAL(10, 2)
);
INSERT INTO journal_entrie
(entry_id, entry_date, account_name, description, debit, credit)
VALUES
(1, '2026-01-01', 'Cash', 'Capital introduced', 50000, 0),

(2, '2026-01-01', 'Capital', 'Capital introduced', 0, 50000),

(3, '2026-01-03', 'Purchases', 'Goods purchased for cash', 20000, 0),

(4, '2026-01-03', 'Cash', 'Goods purchased for cash', 0, 20000),

(5, '2026-01-05', 'Rent', 'Rent paid in cash', 5000, 0),

(6, '2026-01-05', 'Cash', 'Rent paid in cash', 0, 5000),

(7, '2026-01-10', 'Cash', 'Goods sold for cash', 30000, 0),

(8, '2026-01-10', 'Sales', 'Goods sold for cash', 0, 30000),

(9, '2026-01-15', 'Furniture', 'Furniture purchased for cash', 10000, 0),

(10, '2026-01-15', 'Cash', 'Furniture purchased for cash', 0, 10000);
select * from journal_entrie;
select  
	sum(debit) as Total_debit,
    sum(credit) as Total_debit
from journal_entrie;
select
	avg(debit) as debit_average,
    avg(credit) as credit_average
from journal_entrie;
select 
	count(*) as total 
from journal_entrie;
select
	min(debit) as minimum_debit,
    min(credit) as minimum_credit
from journal_entrie;
select
	max(debit) as max_debit,
    max(credit) as max_credit
from journal_entrie;
select account_name,
		count(*) as Total
from journal_entrie
group by account_name;

select * from journal_entrie;

select account_name,
        avg(debit) as debit_average,
        avg(credit) as credit_average
from journal_entrie
group by account_name;

select description,
		sum(debit) as total_debit,
        sum(credit) as total_credit
from journal_entrie
group by description
having sum(debit)>20000;

select description,
		count(*) as total
from journal_entrie
group by description
having sum(credit)<20000;

#trial balance

select 
		case
        when sum(debit) > sum(credit)
        then sum(debit) - sum(credit)
        else 0
end as debit_balance,
		case 
        when sum(credit) > sum(debit)
        then sum(credit) - sum(debit)
        else 0
end as credit_balance
from journal_entrie 
group by account_name;

