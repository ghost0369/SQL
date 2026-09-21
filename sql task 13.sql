use sqlworks_database ;
CREATE TABLE customer (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE transaction (
  transaction_id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  transaction_date DATE NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE salaries (
  employee_id INT PRIMARY KEY,
  employee_name VARCHAR(255) NOT NULL,
  salary DECIMAL(10, 2) NOT NULL
);


select*from customer;
select*from transaction;
select*from salaries;

create user 'manger'@'localhost' identified  by 'man@1234';

create user 'accountant'@'localhost' identified  by 'acc@1234';

create user 'clerk'@'localhost' identified  by 'clerk@1234';

grant select on permission.*
to'accountant'@'localhost';

grant select, insert,update
on sqlworks_database.transactions
to "accountant"@"localhost";

grant select
on sqlworks_database.Customers
to "accountant"@"localhost";

grant select
on sqlworks_database.Customer
to "clerk"@"localhost";

grant select on sqlworks_database.*
to "manager"@"localhost";

grant select,insert, update
on sqlworks_database.transactions
to "accountant"@"localhost";

grant select
on sqlworks_database.transactions
to "accountant"@"localhost";

grant select
on sqlworks_database.customeres
to "clerk"@"localhost";

grant select,insert, update
on sqlworks_database.transactions
to "clerk"@"localhost";

grant select
on sqlworks_database.customeres
to "accountant"@"localhost";

grant delete
on sqlworks_database.transactions
to "accountant"@"localhost";

revoke delete
on sqlworks_database.transactions
from "accountant"@"localhost";

show grants for "manager"@"localhost";
show grants for "accountant"@"localhost";
show grants for "clerk"@"localhost";