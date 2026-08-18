use FinancialDB; 
create table customer(
Customer_id int primary key,
Customer_name varchar(20) not null,
Email varchar(40),
Phone varchar (20)
);
select*from customer;
INSERT INTO Customer (Customer_id, Customer_name, Email, Phone)
VALUES
(1, 'Thushar', 'thuchii@gmail.com', 9353897612),
(2, 'Rahul', 'yajnesh@gmail.com', 555669932),
(3, 'Anu', 'alisha@gmail.com', 8956238956),
(4, 'John', 'wilson@gmail.com', 9876543212),
(5, 'Priya', 'kiran@gmail.com', 8765432109);
select*from customer;

create table accounts(
account_id int primary key,
customer_id int,
account_type varchar(40) not null,
balance int,
foreign key(Customer_id)
references customers(Customer_id)
);
select * from accounts;
INSERT INTO accounts
VALUES
(107, 1, 'Savings', 25000),
(109, 2, 'Current', 45000),
(108, 3, 'Savings', 30000),
(104, 4, 'Salary', 55000),
(105, 5, 'Savings', 40000);
create table transactions(
transaction_id int,
account_id int,
transaction_date date,
transaction_type varchar(40),
amount int not null,
foreign key (account_id)
references accounts(account_id)
);

alter table Customers add address varchar(40);
select * from Customers;
create table temporary_table (
temporary_id int
);
drop table accounts;