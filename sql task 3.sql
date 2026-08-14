use wilson_database;
create table invoice_list (
Invoice_No int primary key,
Invoice_Date date,accounts
Customer Varchar(20),
Amount int
)
select*from invoice_list;
select*from invoice_list;
update invoice_list
set Customer="kiran"
where Invoice_No=1001;
select*from invoice_list;
update invoice_list
set Amount =3500
where Invoice_No=1001;
select*from invoice_list;
update invoice_list
set Customer="dinesha"
where Invoice_No=1002;
select*from invoice_list;
update invoice_list
set Amount =2000
where Invoice_No=1002;
select*from invoice_list;
update invoice_list
set Customer="wilson"
where Invoice_No=1004;
select*from invoice_list;
delete from invoice_list
where Invoice_No=1001;
select*from invoice_list;
delete from invoice_list
where Invoice_No=1002;
select*from invoice_list;
delete from invoice_list
where Invoice_No=1003;
select*from invoice_list;
delete from invoice_list
where Invoice_No=1004;
select*from invoice_list;
delete from invoice_list
where Invoice_No=1005;
select*from invoice_list;