use sqltask_database;
CREATE TABLE transactions2 (
    transaction_id INT PRIMARY KEY,
    account_name VARCHAR(50),
    transaction_type VARCHAR(10),
    amount DECIMAL(10,2),
    transaction_date DATE
);

INSERT INTO transactions2
(transaction_id, account_name, transaction_type, amount, transaction_date)
VALUES
(101, 'Arjun', 'Credit', 68000.00, '2026-10-02'),
(102, 'Meera', 'Debit', 22000.00, '2026-10-04'),
(103, 'Kiran', 'Credit', 95000.00, '2026-10-08'),
(104, 'Divya', 'Debit', 18000.00, '2026-10-11'),
(105, 'Rohan', 'Credit', 45000.00, '2026-10-15');

select*from transactions2;

create table audit_transactions(
	audit_id int auto_increment primary key,
    transaction_id int,
    account_name varchar(50),
    transaction_type varchar(50),
    amount decimal(10,2),
    action_type varchar(50),
    action_time timestamp default current_timestamp
    );
    DELIMITER //
create trigger after_transaction_insert
after insert on transactions2
for each row 
begin 
	insert into audit_transactions
    (transaction_id,account_name,transaction_type,amount,action_type)
    values
    (new.transaction_id,new.account_name,new.transaction_type,new.amount,"insert");
end//
delimiter //
INSERT INTO transactions
(transaction_id, account_name, transaction_type, amount, transaction_date)
VALUES
(106, 'Nisha', 'Debit', 28000.00, '2026-10-18');

SELECT * FROM audit_transactions;

CREATE TRIGGER after_transaction_update
AFTER UPDATE ON transactions
FOR EACH ROW
BEGIN
    INSERT INTO audit_transactions
    (transaction_id,account_name,transaction_type,amount,action_type)
    VALUES
    (NEW.transaction_id,
     NEW.account_name,
     NEW.transaction_type,
     NEW.amount,
     'UPDATE');
END //

UPDATE transactions
SET amount = 65200
WHERE transaction_id = 3;

SELECT * FROM audit_transactions;

DELIMITER //

CREATE TRIGGER after_transaction_deleted
AFTER DELETE ON transactions
FOR EACH ROW
BEGIN
    INSERT INTO audit_transactions
    (transaction_id,account_name,transaction_type,amount,action_type)

    VALUES
    (OLD.transaction_id,
     OLD.account_name,
     OLD.transaction_type,
     OLD.amount,
     'DELETE');
END //

DELIMITER ;
DELETE FROM transactions
WHERE transaction_id = 17;

SELECT * FROM audit_transactions;
SELECT * FROM audit_transactions;
