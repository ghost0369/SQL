use wilson_database;
CREATE TABLE Customer(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Product VARCHAR(50),
    OrderAmount DECIMAL(10,2)
);
INSERT INTO Customer VALUES
(1, 'Akhil', 'Kochi'),
(2, 'Rahul', 'Bangalore'),
(3, 'Meera', 'Chennai'),
(4, 'Anu', 'Mangalore'),
(5, 'Vishnu', 'Delhi'),
(6, 'Neha', 'Mumbai');

INSERT INTO Orders VALUES
(101, 1, 'Laptop', 50000),
(102, 2, 'Mobile', 30000),
(103, 3, 'Tablet', 25000),
(104, 7, 'Printer', 15000),
(105, 8, 'Monitor', 20000);
  
  select*from Customer;
  select*from Orders;
  select 
      c.CustomerID,
      c.CustomerName,
      o.OrderID,
      o.Product,
      o.OrderAmount
from Customer c
Right Join Orders o
on c.CustomerID=o.OrderID;

select 
      c.CustomerID,
      c.CustomerName,
      o.OrderID,
      o.Product,
      o.OrderAmount
from Customer c
Left Join Orders o
on c.CustomerID=o.OrderID;
select 
      c.CustomerID,
      c.CustomerName,
      o.OrderID,
      o.Product,
      o.OrderAmount
from Customer c
Inner Join Orders o
on c.CustomerID=o.OrderID;

SELECT 
     c.Customer_ID,
    c.Customer_Name,
    o.Order_ID,
    o.Order_Amount,
    i.Invoice_ID,
    i.Invoice_Amount,
    p.Payment_ID,
    p.Payment_Amount,
    l.Ledger_ID,
    l.Debit,
    l.Credit
from Customerss c
LEFT JOIN Orders o
ON c.Customer_ID=o.Customer_ID
LEFT JOIN Invoices i
ON o.Order_ID=i.Order_ID
LEFT JOIN Payments p
ON i.Invoice_ID=p.Invoice_ID
LEFT JOIN Ledger l
ON c.Customer_ID=l.Customer_ID;