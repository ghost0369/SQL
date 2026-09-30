create  database mysql_projectdb;
use mysql_projectdb;

 -- Question 1 
 CREATE TABLE fin_customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(80) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(40)
);

CREATE TABLE fin_account (
    account_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    account_type VARCHAR(30) NOT NULL,
    opening_balance DECIMAL(12,2) DEFAULT 0.00,
    FOREIGN KEY (customer_id)
        REFERENCES fin_customer(customer_id)
);

CREATE TABLE fin_transaction (
    transaction_id INT PRIMARY KEY,
    account_id INT NOT NULL,
    transaction_date DATE NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (account_id)
        REFERENCES fin_account(account_id)
);

CREATE TABLE fin_invoice (
    invoice_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    invoice_date DATE NOT NULL,
    invoice_amount DECIMAL(12,2) NOT NULL,
    invoice_status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (customer_id)
        REFERENCES fin_customer(customer_id)
);

CREATE TABLE fin_payment (
    payment_id INT PRIMARY KEY,
    invoice_id INT NOT NULL,
    payment_date DATE NOT NULL,
    payment_amount DECIMAL(12,2) NOT NULL,
    payment_method VARCHAR(30),
    FOREIGN KEY (invoice_id)
        REFERENCES fin_invoice(invoice_id)
);

CREATE TABLE fin_expense (
    expense_id INT PRIMARY KEY,
    expense_date DATE NOT NULL,
    expense_category VARCHAR(40) NOT NULL,
    expense_amount DECIMAL(12,2) NOT NULL,
    expense_note VARCHAR(100)
);

CREATE TABLE fin_ledger (
    ledger_id INT PRIMARY KEY,
    account_id INT NOT NULL,
    entry_date DATE NOT NULL,
    entry_type VARCHAR(20) NOT NULL,
    ledger_amount DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (account_id)
        REFERENCES fin_account(account_id)
);

-- -- insert values 

INSERT INTO fin_customer VALUES
(101, 'Aarav Dsouza', 'aarav@gmail.com', '9876512340', 'Mangalore'),
(102, 'Riya Nair', 'riya@gmail.com', '9876523451', 'Udupi'),
(103, 'Dev Shetty', 'dev@gmail.com', '9876534562', 'Mysore'),
(104, 'Sara Fernandes', 'sara@gmail.com', '9876545673', 'Bangalore'),
(105, 'Neil Pinto', 'neil@gmail.com', '9876556784', 'Manipal');

INSERT INTO fin_account VALUES
(2001, 101, 'Savings', 65000.00),
(2002, 102, 'Current', 120000.00),
(2003, 103, 'Savings', 48000.00),
(2004, 104, 'Current', 175000.00),
(2005, 105, 'Savings', 82000.00);

INSERT INTO fin_transaction VALUES
(3001, 2001, '2026-01-05', 'Credit', 25000.00),
(3002, 2002, '2026-01-08', 'Debit', 18000.00),
(3003, 2003, '2026-01-15', 'Credit', 32000.00),
(3004, 2004, '2026-02-03', 'Debit', 27000.00),
(3005, 2005, '2026-02-12', 'Credit', 41000.00);

INSERT INTO fin_invoice VALUES
(4001, 101, '2026-01-10', 45000.00, 'Paid'),
(4002, 102, '2026-01-18', 68000.00, 'Pending'),
(4003, 103, '2026-02-05', 52000.00, 'Paid'),
(4004, 104, '2026-02-20', 85000.00, 'Pending'),
(4005, 105, '2026-03-02', 39000.00, 'Paid');

INSERT INTO fin_payment VALUES
(5001, 4001, '2026-01-12', 45000.00, 'UPI'),
(5002, 4003, '2026-02-07', 52000.00, 'Bank Transfer'),
(5003, 4005, '2026-03-04', 39000.00, 'Debit Card');

INSERT INTO fin_expense VALUES
(6001, '2026-01-06', 'Rent', 15000.00, 'Office rent'),
(6002, '2026-01-20', 'Salary', 55000.00, 'Staff salary'),
(6003, '2026-02-11', 'Utilities', 8500.00, 'Electricity and internet'),
(6004, '2026-02-25', 'Transport', 7200.00, 'Business travel'),
(6005, '2026-03-10', 'Marketing', 12500.00, 'Online promotion');

INSERT INTO fin_ledger VALUES
(7001, 2001, '2026-01-05', 'Credit', 25000.00),
(7002, 2002, '2026-01-06','Debit', 18000.00),
(7003, 2003, '2026-01-07','Credit', 32000.00),
(7004, 2004, '2026-01-08','Debit', 27000.00),
(7005, 2005, '2026-01-09','Credit', 41000.00);
 
-- SHOW TABLES;

SELECT * FROM fin_customer;
SELECT * FROM fin_account;
SELECT * FROM fin_transaction;
SELECT * FROM fin_invoice;
SELECT * FROM fin_payment;
SELECT * FROM fin_expense;
SELECT * FROM fin_ledger;

-- question 2 

-- --Display customers from a particular city
SELECT
    customer_id,
    customer_name,
    city
FROM fin_customer
WHERE city = 'Mangalore';

-- --Display accounts with balance above 70,000
SELECT
    account_id,
    customer_id,
    account_type,
    opening_balance
FROM fin_account
WHERE opening_balance > 70000;

-- --Display all credit transactions
SELECT
    transaction_id,
    account_id,
    transaction_date,
    amount
FROM fin_transaction
WHERE transaction_type = 'Credit';


-- Display transactions between two dates
SELECT
    transaction_id,
    account_id,
    transaction_date,
    transaction_type,
    amount
FROM fin_transaction
WHERE transaction_date
BETWEEN '2026-01-01' AND '2026-02-28';

-- --Highest transaction amount first

SELECT
    transaction_id,
    account_id,
    transaction_type,
    amount
FROM fin_transaction
ORDER BY amount DESC;

-- --Latest transactions first

SELECT
    transaction_id,
    account_id,
    transaction_date,
    transaction_type,
    amount
FROM fin_transaction
ORDER BY transaction_date DESC;

-- --Total money credited

SELECT
    SUM(amount) AS total_credit
FROM fin_transaction
WHERE transaction_type = 'Credit';

-- --Total money debited

SELECT
    SUM(amount) AS total_debit
FROM fin_transaction
WHERE transaction_type = 'Debit';

-- --Average transaction amount

SELECT
    AVG(amount) AS average_transaction
FROM fin_transaction;

-- --Highest transaction

SELECT
    MAX(amount) AS highest_transaction
FROM fin_transaction;

-- --Lowest transaction

SELECT
    MIN(amount) AS lowest_transaction
FROM fin_transaction;

-- --Total amount by transaction type

SELECT
    transaction_type,
    COUNT(*) AS number_of_transactions,
    SUM(amount) AS total_amount
FROM fin_transaction
GROUP BY transaction_type;
 
 SELECT
    account_id,
    customer_id,
    opening_balance,

    CASE
        WHEN opening_balance >= 150000
            THEN 'High Balance'

        WHEN opening_balance >= 70000
            THEN 'Medium Balance'

        ELSE 'Low Balance'
    END AS balance_category

FROM fin_account;

SELECT
    invoice_status,
    COUNT(*) AS invoice_count,
    SUM(invoice_amount) AS total_invoice_value
FROM fin_invoice
GROUP BY invoice_status;

SELECT
    expense_category,
    COUNT(*) AS expense_count,
    SUM(expense_amount) AS total_expense
FROM fin_expense
GROUP BY expense_category
ORDER BY total_expense DESC;

SELECT
    YEAR(expense_date) AS expense_year,
    MONTH(expense_date) AS expense_month,
    SUM(expense_amount) AS monthly_expense
FROM fin_expense
GROUP BY
    YEAR(expense_date),
    MONTH(expense_date)
ORDER BY
    expense_year,
    expense_month;
    
    SELECT
    (SELECT SUM(amount)
     FROM fin_transaction
     WHERE transaction_type = 'Credit') AS total_credit,

    (SELECT SUM(amount)
     FROM fin_transaction
     WHERE transaction_type = 'Debit') AS total_debit,

    (SELECT SUM(expense_amount)
     FROM fin_expense) AS total_expenses,

    (SELECT SUM(invoice_amount)
     FROM fin_invoice) AS total_invoice_value;
     
    -- question 3 CUSTOMER & ACCOUNT ANALYSIS
    
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    a.account_id,
    a.account_type,
    a.opening_balance
FROM fin_customer c
INNER JOIN fin_account a
    ON c.customer_id = a.customer_id;

 SELECT
    c.customer_name,
    a.account_id,
    t.transaction_date,
    t.transaction_type,
    t.amount
FROM fin_customer c
INNER JOIN fin_account a
    ON c.customer_id = a.customer_id
INNER JOIN fin_transaction t
    ON a.account_id = t.account_id
ORDER BY t.transaction_date;

SELECT
    c.customer_name,
    c.city,
    i.invoice_id,
    i.invoice_date,
    i.invoice_amount,
    i.invoice_status
FROM fin_customer c 
INNER JOIN fin_invoice i
    ON c.customer_id = i.customer_id;
    
    SELECT
    i.invoice_id,
    c.customer_name,
    i.invoice_amount,
    p.payment_date,
    p.payment_amount,
    p.payment_method
FROM fin_invoice i
INNER JOIN fin_customer c
    ON i.customer_id = c.customer_id
LEFT JOIN fin_payment p
    ON i.invoice_id = p.invoice_id;
    
    SELECT
    c.customer_id,
    c.customer_name,
    i.invoice_id,
    i.invoice_amount
FROM fin_customer c
INNER JOIN fin_invoice i
    ON c.customer_id = i.customer_id
LEFT JOIN fin_payment p
    ON i.invoice_id = p.invoice_id
WHERE p.payment_id IS NULL;

SELECT
    c.customer_id,
    c.customer_name,
    SUM(t.amount) AS total_transaction_amount
FROM fin_customer c
INNER JOIN fin_account a
    ON c.customer_id = a.customer_id
INNER JOIN fin_transaction t
    ON a.account_id = t.account_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_transaction_amount DESC;

SELECT
    c.customer_name,
    a.account_type,
    a.opening_balance,
    COALESCE(SUM(t.amount), 0) AS transaction_value,
    COALESCE(SUM(p.payment_amount), 0) AS payments_made
FROM fin_customer c
LEFT JOIN fin_account a
    ON c.customer_id = a.customer_id
LEFT JOIN fin_transaction t
    ON a.account_id = t.account_id
LEFT JOIN fin_invoice i
    ON c.customer_id = i.customer_id
LEFT JOIN fin_payment p
    ON i.invoice_id = p.invoice_id
GROUP BY
    c.customer_id,
    c.customer_name,
    a.account_type,
    a.opening_balance;
    
    SELECT
    a.account_id,
    a.account_type,
    COUNT(t.transaction_id) AS transaction_count,
    SUM(t.amount) AS total_transaction_value,
    AVG(t.amount) AS average_transaction_value
FROM fin_account a
LEFT JOIN fin_transaction t
    ON a.account_id = t.account_id
GROUP BY
    a.account_id,
    a.account_type
ORDER BY total_transaction_value DESC;

SELECT
    c.customer_name,
    a.account_id,
    t.transaction_type,
    t.amount AS transaction_amount,
    i.invoice_amount,
    p.payment_amount
FROM fin_customer c
LEFT JOIN fin_account a
    ON c.customer_id = a.customer_id
LEFT JOIN fin_transaction t
    ON a.account_id = t.account_id
LEFT JOIN fin_invoice i
    ON c.customer_id = i.customer_id
LEFT JOIN fin_payment p
    ON i.invoice_id = p.invoice_id;
    
SELECT
    c.customer_name,
    SUM(a.opening_balance) AS account_balance,
    COALESCE(SUM(t.amount), 0) AS transaction_value,
    COALESCE(SUM(i.invoice_amount), 0) AS invoice_value
FROM fin_customer c
LEFT JOIN fin_account a
    ON c.customer_id = a.customer_id
LEFT JOIN fin_transaction t
    ON a.account_id = t.account_id
LEFT JOIN fin_invoice i
    ON c.customer_id = i.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY account_balance DESC;

-- Question FINANCIAL MANAGEMENT VIEWS
CREATE VIEW customer_account_overview AS
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    a.account_id,
    a.account_type,
    a.opening_balance
FROM fin_customer c
JOIN fin_account a
    ON c.customer_id = a.customer_id;
    
    SELECT *
FROM customer_account_overview;

CREATE VIEW transaction_activity AS
SELECT
    c.customer_name,
    a.account_id,
    t.transaction_id,
    t.transaction_date,
    t.transaction_type,
    t.amount
FROM fin_customer c
JOIN fin_account a
    ON c.customer_id = a.customer_id
JOIN fin_transaction t
    ON a.account_id = t.account_id;
    
    SELECT *
FROM transaction_activity
ORDER BY transaction_date DESC;
    
CREATE VIEW outstanding_invoices AS
SELECT
    i.invoice_id,
    c.customer_name,
    i.invoice_date,
    i.invoice_amount,
    i.invoice_status
FROM fin_invoice i
JOIN fin_customer c
    ON i.customer_id = c.customer_id
WHERE i.invoice_status = 'Pending';

SELECT *
FROM outstanding_invoices;

CREATE VIEW payment_tracking AS
SELECT
    c.customer_name,
    i.invoice_id,
    i.invoice_amount,
    p.payment_id,
    p.payment_date,
    p.payment_amount,
    p.payment_method
FROM fin_customer c
JOIN fin_invoice i
    ON c.customer_id = i.customer_id
LEFT JOIN fin_payment p
    ON i.invoice_id = p.invoice_id;
    
    SELECT *
FROM payment_tracking;

CREATE VIEW expense_summary AS
SELECT
    expense_category,
    COUNT(expense_id) AS number_of_expenses,
    SUM(expense_amount) AS total_expense,
    AVG(expense_amount) AS average_expense
FROM fin_expense
GROUP BY expense_category;

SELECT *
FROM expense_summary
ORDER BY total_expense DESC;

CREATE VIEW customer_financial_position AS
SELECT
    c.customer_id,
    c.customer_name,
    COALESCE(a.opening_balance, 0) AS account_balance,
    COALESCE(i.total_invoice, 0) AS total_invoice,
    COALESCE(p.total_payment, 0) AS total_payment
FROM fin_customer c

LEFT JOIN
(
    SELECT
        customer_id,
        SUM(opening_balance) AS opening_balance
    FROM fin_account
    GROUP BY customer_id
) a
ON c.customer_id = a.customer_id

LEFT JOIN
(
    SELECT
        customer_id,
        SUM(invoice_amount) AS total_invoice
    FROM fin_invoice
    GROUP BY customer_id
) i
ON c.customer_id = i.customer_id

LEFT JOIN
(
    SELECT
        i.customer_id,
        SUM(p.payment_amount) AS total_payment
    FROM fin_invoice i
    JOIN fin_payment p
        ON i.invoice_id = p.invoice_id
    GROUP BY i.customer_id
) p
ON c.customer_id = p.customer_id;

SELECT *
FROM customer_financial_position;

-- Question 5 ADVANCED FINANCIAL ANALYSIS

USE FinancialManagementSystem;

SELECT
    account_id,
    customer_id,
    account_type,
    opening_balance
FROM fin_account
WHERE opening_balance >
(
    SELECT AVG(opening_balance)
    FROM fin_account
);

SELECT
    c.customer_name,
    a.account_id,
    a.account_type,
    a.opening_balance
FROM fin_customer c
JOIN fin_account a
    ON c.customer_id = a.customer_id
WHERE a.opening_balance =
(
    SELECT MAX(opening_balance)
    FROM fin_account
);

--  Question 6 CTE-BASED FINANCIAL ANALYSIS


WITH customer_accounts AS
(
    SELECT
        c.customer_id,
        c.customer_name,
        a.account_type,
        a.opening_balance
    FROM fin_customer c
    JOIN fin_account a
        ON c.customer_id = a.customer_id
)
SELECT *
FROM customer_accounts;

WITH account_analysis AS
(
    SELECT
        c.customer_id,
        c.customer_name,
        a.opening_balance
    FROM fin_customer c
    JOIN fin_account a
        ON c.customer_id = a.customer_id
),
average_balance AS
(
    SELECT AVG(opening_balance) AS avg_balance
    FROM account_analysis
)
SELECT
    customer_id,
    customer_name,
    opening_balance
FROM account_analysis
WHERE opening_balance >
(
    SELECT avg_balance
    FROM average_balance
);

WITH financial_totals AS
(
    SELECT
        (SELECT SUM(invoice_amount)
         FROM fin_invoice) AS total_revenue,

        (SELECT SUM(expense_amount)
         FROM fin_expense) AS total_expenses
)
SELECT
    total_revenue,
    total_expenses,
    total_revenue - total_expenses AS net_financial_position
FROM financial_totals;

-- FINANCIAL PERFORMANCE USING WINDOW FUNCTIONS

SELECT
    transaction_id,
    account_id,
    transaction_type,
    amount,
    RANK() OVER (
        ORDER BY amount DESC
    ) AS transaction_rank
FROM fin_transaction;

SELECT
    customer_id,
    invoice_id,
    invoice_date,
    invoice_amount,

    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY invoice_amount DESC
    ) AS invoice_rank

FROM fin_invoice;

-- Question 8 STORED PROCEDURES & AUTOMATED FINANCIAL OPERATIONS

DELIMITER //

CREATE PROCEDURE account_summary(
    IN p_account_id INT
)
BEGIN

    SELECT
        a.account_id,
        c.customer_name,
        a.account_type,
        a.opening_balance,

        COALESCE(
            SUM(t.amount),
            0
        ) AS transaction_value

    FROM fin_account a

    JOIN fin_customer c
        ON a.customer_id = c.customer_id

    LEFT JOIN fin_transaction t
        ON a.account_id = t.account_id

    WHERE a.account_id = p_account_id

    GROUP BY
        a.account_id,
        c.customer_name,
        a.account_type,
        a.opening_balance;

END //

DELIMITER ;

CALL account_summary(2001);

DELIMITER //

CREATE PROCEDURE customer_financial_details(
    IN p_customer_id INT
)
BEGIN

    SELECT
        c.customer_id,
        c.customer_name,
        c.city,
        a.account_id,
        a.account_type,
        a.opening_balance
    FROM fin_customer c

    LEFT JOIN fin_account a
        ON c.customer_id = a.customer_id

    WHERE c.customer_id = p_customer_id;

END //

DELIMITER ;
CALL customer_financial_details(101);

-- Question 9 TRANSACTION AUDIT & TRIGGERS



CREATE TABLE transaction_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT,
    account_id INT,
    action_type VARCHAR(20),
    old_amount DECIMAL(12,2),
    new_amount DECIMAL(12,2),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER trg_transaction_insert
AFTER INSERT ON fin_transaction
FOR EACH ROW
BEGIN

    INSERT INTO transaction_audit
    (
        transaction_id,
        account_id,
        action_type,
        old_amount,
        new_amount
    )
    VALUES
    (
        NEW.transaction_id,
        NEW.account_id,
        'INSERT',
        NULL,
        NEW.amount
    );

END //

DELIMITER ;

UPDATE fin_transaction
SET amount = 31000.00
WHERE transaction_id = 3010;

SELECT *
FROM transaction_audit;

-- Question 10 DATABASE SECURITY & ACCESS CONTROL

CREATE USER IF NOT EXISTS
'finance_viewer'@'localhost'
IDENTIFIED BY 'Viewer@123';

GRANT SELECT
ON FinancialManagementSystem.*
TO 'finance_viewer'@'localhost';

CREATE USER IF NOT EXISTS
'finance_operator'@'localhost'
IDENTIFIED BY 'Operator@123';

GRANT
SELECT,
INSERT,
UPDATE
ON FinancialManagementSystem.*
TO 'finance_operator'@'localhost';

-- Question 11 MANAGEMENT FINANCIAL REPORTS

SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    COALESCE(a.total_balance, 0) AS account_balance,
    COALESCE(i.total_invoice, 0) AS total_invoice,
    COALESCE(p.total_payment, 0) AS total_payment,
    COALESCE(i.total_invoice, 0)
        - COALESCE(p.total_payment, 0) AS outstanding_amount
FROM fin_customer c

LEFT JOIN
(
    SELECT
        customer_id,
        SUM(opening_balance) AS total_balance
    FROM fin_account
    GROUP BY customer_id
) a
ON c.customer_id = a.customer_id

LEFT JOIN
(
    SELECT
        customer_id,
        SUM(invoice_amount) AS total_invoice
    FROM fin_invoice
    GROUP BY customer_id
) i
ON c.customer_id = i.customer_id

LEFT JOIN
(
    SELECT
        fi.customer_id,
        SUM(fp.payment_amount) AS total_payment
    FROM fin_invoice fi
    JOIN fin_payment fp
        ON fi.invoice_id = fp.invoice_id
    GROUP BY fi.customer_id
) p
ON c.customer_id = p.customer_id;

SELECT
    expense_category,
    COUNT(*) AS number_of_expenses,
    SUM(expense_amount) AS total_expense,
    AVG(expense_amount) AS average_expense
FROM fin_expense
GROUP BY expense_category
ORDER BY total_expense DESC;

SELECT
    (SELECT SUM(invoice_amount)
     FROM fin_invoice) AS total_invoice_value,

    (SELECT SUM(payment_amount)
     FROM fin_payment) AS total_payments_received,

    (SELECT SUM(expense_amount)
     FROM fin_expense) AS total_expenses,

    (SELECT SUM(opening_balance)
     FROM fin_account) AS total_account_balance,

    (SELECT SUM(invoice_amount)
     FROM fin_invoice)
    -
    (SELECT SUM(payment_amount)
     FROM fin_payment) AS total_outstanding;
     
     -- Question 12 FINAL INTEGRATED FINANCIAL ANALYSIS
     
     SELECT
    c.customer_id,
    c.customer_name,

    COALESCE(a.account_balance, 0) AS account_balance,
    COALESCE(i.invoice_value, 0) AS invoice_value,
    COALESCE(p.payment_value, 0) AS payment_value,

    COALESCE(i.invoice_value, 0)
        - COALESCE(p.payment_value, 0) AS outstanding_amount

FROM fin_customer c

LEFT JOIN
(
    SELECT
        customer_id,
        SUM(opening_balance) AS account_balance
    FROM fin_account
    GROUP BY customer_id
) a
ON c.customer_id = a.customer_id

LEFT JOIN
(
    SELECT
        customer_id,
        SUM(invoice_amount) AS invoice_value
    FROM fin_invoice
    GROUP BY customer_id
) i
ON c.customer_id = i.customer_id

LEFT JOIN
(
    SELECT
        fi.customer_id,
        SUM(fp.payment_amount) AS payment_value
    FROM fin_invoice fi
    JOIN fin_payment fp
        ON fi.invoice_id = fp.invoice_id
    GROUP BY fi.customer_id
) p
ON c.customer_id = p.customer_id

ORDER BY outstanding_amount DESC;

SELECT
    (SELECT COALESCE(SUM(invoice_amount), 0)
     FROM fin_invoice) AS total_revenue,

    (SELECT COALESCE(SUM(payment_amount), 0)
     FROM fin_payment) AS total_received,

    (SELECT COALESCE(SUM(expense_amount), 0)
     FROM fin_expense) AS total_expenses,

    (SELECT COALESCE(SUM(invoice_amount), 0)
     FROM fin_invoice)
    -
    (SELECT COALESCE(SUM(expense_amount), 0)
     FROM fin_expense) AS revenue_after_expenses;
     
     -- Final summary 
     
     SHOW FULL TABLES
WHERE Table_type = 'VIEW';

SHOW PROCEDURE STATUS
WHERE Db = 'FinancialManagementSystem';

SHOW TRIGGERS
from mysql_projectdb ;