create database FinancialDB;
USE FinancialDB;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(15)
);

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    AccountType VARCHAR(50),
    Balance DECIMAL(12,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Ledgers (
    LedgerID INT PRIMARY KEY,
    AccountID INT NOT NULL,
    LedgerName VARCHAR(100),
    Balance DECIMAL(12,2),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT NOT NULL,
    TransactionDate DATE,
    TransactionType VARCHAR(50),
    Amount DECIMAL(12,2),
    Description VARCHAR(255),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Invoices (
    InvoiceID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    InvoiceDate DATE,
    DueDate DATE,
    Amount DECIMAL(12,2),
    Status VARCHAR(30),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    InvoiceID INT NOT NULL,
    PaymentDate DATE,
    Amount DECIMAL(12,2),
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID)
);
INSERT INTO Customers (CustomerID, CustomerName, Email, Phone) VALUES 
(1,"Arjun","arjun@gmail.com",9876543210),
(2,"Rohan","rohan@gmail.com",8765432109),
(3,"Kiran","kiran@gmail.com",7654321098);
SELECT * FROM Customers;

INSERT INTO Accounts (AccountID,CustomerID,AccountType,Balance) VALUES 
(101,1,"savings",30000),
(102,2,"current",45000),
(103,3,"savings",65000);
SELECT * FROM Accounts;

INSERT INTO Ledgers
(LedgerID, AccountID, LedgerName, Balance)
VALUES
(201,101,'Savings Ledger',30000.00),
(202,102,'Current Ledger',45000.00),
(203,103,'Savings Ledger',65000.00);
SELECT * FROM Ledgers;

INSERT INTO Transactions
(TransactionID, AccountID, TransactionDate, TransactionType, Amount, Description)
VALUES
(301,101,'2026-08-10','Deposit',7000.00,'Online Deposit'),
(302,102,'2026-08-10','Withdrawal',3000.00,'ATM Withdrawal'),
(303,103,'2026-08-10','Deposit',5000.00,'Cash Deposit');
SELECT * FROM Transactions;

INSERT INTO Invoices
(InvoiceID, CustomerID, InvoiceDate, DueDate, Amount, Status)
VALUES
(401,1,'2026-08-10','2026-08-21',6000.00,'Pending'),
(402,2,'2026-08-10','2026-08-26',8500.00,'Paid'),
(403,3,'2026-08-10','2026-08-31',4000.00,'Pending');
SELECT * FROM Invoices;

INSERT INTO Payments
(PaymentID, InvoiceID, PaymentDate, Amount, PaymentMethod)
VALUES
(501,402,'2026-08-11',8500.00,'UPI'),
(502,401,'2026-08-12',2500.00,'Cash'),
(503,403,'2026-08-13',4000.00,'Bank Transfer');
SELECT * FROM Payments;
