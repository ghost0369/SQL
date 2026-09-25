-- 1 load database 
use mydb;
-- 2. Create Table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    transaction_date DATE,
    amount DECIMAL(10,2),
    payment_method VARCHAR(20)
);


-- 3. Insert Data
INSERT INTO transactions
VALUES
(1, 101, '2026-01-01', 5000, 'UPI'),
(2, 102, '2026-01-02', 3000, 'Card'),
(3, 101, '2026-01-03', 7000, 'UPI'),
(4, 103, '2026-01-04', 60000, 'Bank'),
(5, 104, '2026-01-05', 2500, 'UPI'),
(6, 101, '2026-01-06', 5000, 'UPI'),
(7, 101, '2026-01-06', 5000, 'UPI'),
(8, NULL, '2026-01-07', 4000, 'Card'),
(9, 105, '2026-01-08', NULL, 'UPI'),
(10, 106, NULL, 3500, 'Card'),
(11, 107, '2026-01-09', -500, 'UPI'),
(12, 108, '2026-01-10', 80000, 'Bank');

-- 4 show table 
select*from transactions;

--  5 check qurey perfrommannce 
explain 
select*from transactions
where customer_id=101;


--  6 Index on customer_id
CREATE INDEX idx_customer_id
ON transactions(customer_id);

--  7 show  the Index 
SHOW INDEX FROM transactions;

--  8 duplicate transactions 
select
     customer_id,
     transaction_date,
     amount,
     count(*) as duplicate_counts 
     FROM transactions
     group by customer_id,transaction_date,amount
     having count(*)>1;   
     
--  9 missinng values 
select*from transactions
 where customer_id is null 
	or transaction_date is null 
    or amount is null;
    
--  10 suspicues activities 
select*from transactions
where amount>5000
    or amount <0
    or amount is null
    or customer_id is null
    or transaction_date is null;
    
-- 11 high values 
select*from  transactions
where amount>50000;

-- 12 negtive values 
select*from transactions
where amount<0;

-- 13 multiplues by transactions on same date 
select
	customer_id,
    transaction_date,
    count(*) as transaction_count
from transactions
group by customer_id,transaction_date
having count(*)>1;


