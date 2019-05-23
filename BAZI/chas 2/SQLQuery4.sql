SELECT * 
FROM Employee 
WHERE day(DateOfBirth) = 01 and month(DateOfBirth) = 02


SELECT * 
FROM Employee 
WHERE day(DateOfBirth) > 01 and month(DateOfBirth) = 02

SELECT * 
FROM Employee 
WHERE day(DateOfBirth) > 01 and month(DateOfBirth) > 01 and year(DateOfBirth) > 1988


SELECT * 
FROM Employee 
WHERE FirstName = 'Goran'

SELECT * 
FROM Employee 
WHERE LastName like 'S%'

SELECT * 
FROM Employee 
WHERE Gender = 'M'

SELECT * 
FROM Employee 
WHERE Gender = 'F'

SELECT * 
FROM Employee 
WHERE month(HireDate) = 01 and year(HireDate) = 1998

SELECT * 
FROM Employee 
WHERE LastName like 'A%' and month(HireDate) = 01 and year(HireDate) = 2019

Select *
FROM Employee
order by FirstName asc ,DateOfBirth desc 

SELECT * 
FROM Employee 
where FirstName = 'Aleksandar'
order by LastName

SELECT * 
FROM Employee 
WHERE Gender = 'M'
order by HireDate desc

select FirstName,LastName
from Employee
union
select FirstName,LastName
from Employee

select FirstName,LastName
from Employee
where FirstName='Aleksandar'
intersect 
select FirstName,LastName
from Employee


select Name
from BusinessEntity
union all
select Name
from Customer

select Region
from BusinessEntity
intersect 
select RegionName
from Customer


alter table Product
add constraint DF_Product_Weight
default 100 for [Weight]

alter table Product
add constraint DF_Product_Price
default 1 for [Price]

alter table Product  with check
add constraint new_CHK_Product_Price
Check (price < Cost*2)


insert into Product(price, Cost)
values (30,15)

insert into Product(Name)
values ('kire')


alter table Product  with check
add constraint  uc_Product_Name Unique(Name)

update p set Name = 'Gluten Free New'
from Product p
where name = 'Gluten Free'
and id=13


alter table [Order] with check
add constraint [fk_Order_BuisnessEntity]
foreign key [BuisnessEntityId]
references BuisnessEntity ([Id])

select c.Name as CustomerName
from Customer c

select p.Name as ProductName
from Product p

select c.Name as CustomerName, p.Name as ProductName
from Customer c
cross join Product p
order by CustomerName



select top 10 be.*
from BusinessEntity be

select top 10*
from [Order] 

select Distinct be.Name
from BusinessEntity be
inner join [Order] o on o.BusinessEntityId = be.Id

select Distinct be.Name
from BusinessEntity be
left join [Order] o on o.BusinessEntityId = be.Id

