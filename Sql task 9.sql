CREATE TABLE Employe (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(50),
    Department VARCHAR(50),
    Salary INT,
    City VARCHAR(50)
);

INSERT INTO Employe VALUES
(1, 'Akhil', 'IT', 52000, 'Mangalore'),
(2, 'Meera', 'HR', 47000, 'Bangalore'),
(3, 'Rakesh', 'Finance', 68000, 'Mysore'),
(4, 'Nisha', 'IT', 72000, 'Udupi'),
(5, 'Karthik', 'HR', 49000, 'Hubli'),
(6, 'Pooja', 'Finance', 63000, 'Mangalore'),
(7, 'Manoj', 'IT', 58000, 'Bangalore'),
(8, 'Deepa', 'Marketing', 54000, 'Mysore'),
(9, 'Suresh', 'Finance', 76000, 'Udupi'),
(10, 'Divya', 'Marketing', 60000, 'Hubli');

SELECT * FROM Employe;

select*from Employe where Salary >
(select avg(Salary) from Employe);

select*from Employe where Salary =
(select max(Salary) from Employe);

select*from Employe where Salary <
(select max(Salary) from Employe);

select*from Employe where Salary =
(select Salary from Employe where Employee_Name='Akhil');

select*from Employe where Department =
(select Department from Employe where Employee_Name='pooja');

select*from Employe where Salary >
(select Salary from Employe where Department='HR');

select*from Employe where Department in
(select Department from Employe where Salary>70000);