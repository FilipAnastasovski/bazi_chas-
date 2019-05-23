select top 10* from BusinessEntity
select top 10 * from [Order]
select top 5 * from Employee

select DISTINCT BusinessEntityId , b.Name as BusinessEntityName
 from BusinessEntity b
inner join [Order] o on o.BusinessEntityId=b.Id


select DISTINCT EmployeeId , e.FirstName , e.LastName
 from Employee e
inner join [Order] o on o.EmployeeId=e.Id

select  count(*) as total
from Employee

select Gender , count(*) as total
from Employee
group by Gender


select FirstName , count(*) as total
from Employee
group by FirstName

select SUBSTRING (FirstName,1,1), count(*)
from Employee
group by SUBSTRING (FirstName,1,1)

select SUM(TotalPrice)
from [Order]

select min(TotalPrice)
from [Order]
where TotalPrice>0



select BusinessEntityId, b.Name, sum(TotalPrice)
from [Order] o 
inner join BusinessEntity b on b.Id=o.BusinessEntityId
where o.OrderDate>='2019.05.01'
group by BusinessEntityId,b.Name
order by BusinessEntityId


select BusinessEntityId, b.Name, sum(TotalPrice)
from [Order] o 
inner join BusinessEntity b on b.Id=o.BusinessEntityId
where o.CustomerId<20
group by BusinessEntityId,b.Name
order by BusinessEntityId



select BusinessEntityId, b.Name,o.CustomerId,c.Name as CustomerName,o.EmployeeId,e.FirstName,e.LastName, sum(TotalPrice)
from [Order] o 
inner join BusinessEntity b on b.id = o.BusinessEntityId
inner join Customer c on c.Id=o.CustomerId
inner join Employee e on e.Id=o.EmployeeId
where o.CustomerId<20 and e.Gender='M'
group by BusinessEntityId,b.Name,o.CustomerId,c.Name,o.EmployeeId,e.FirstName,e.LastName
order by BusinessEntityId


SELECT BusinessEntityId,b.Name, max(TotalPrice) as Total, AVG(TotalPrice) as Average+
from [Order] o
inner join BusinessEntity b on b.id = o.BusinessEntityId
group by BusinessEntityId,b.Name


Create view MaleEmployees
as
select Id,FirstName,LastName
from Employee
where Gender='M'

select * from MaleEmployees 


alter view CustomerOrders
as
select c.Name as CustomerName,sum(TotalPrice) as Total
from [Order] o 
inner join Customer c on c.Id=o.CustomerId
group by c.Name

select * from CustomerOrders




alter view vv_EmployeeOrders
as
select e.FirstName,e.LastName,p.Name,sum(od.Quantity) as Quantity,b.Region
from [Order] o
inner join OrderDetails od on od.OrderId = o.Id
inner join Employee e on e.Id = o.EmployeeId
inner join Product p on p.Id = od.ProductId
inner join BusinessEntity b on b.Id = o.BusinessEntityId
where b.Region = 'Skopski'
group by e.FirstName,e.LastName,p.Name,b.Region

 

select * from vv_EmployeeOrders
order by FirstName
