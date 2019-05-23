declare @EmployeeId int
set @EmployeeId = 1
set @EmployeeId = 2

select @EmployeeId

select * 
from Employee e
where e.Id = @EmployeeId

--  List

declare @EmployeeList Table
(EmployeeID int, FirstName nvarchar(100),LastName nvarchar(100));


insert into @EmployeeList
select Id,FirstName,LastName
from Employee
where FirstName like 'A%'


select *
from @EmployeeList el
inner join [Order] o on o.EmployeeId = el.EmployeeID;


----- Table 


Drop Table #EmployeeList	
create Table #EmployeeList	
(EmployeeID int, FirstName nvarchar(100),LastName nvarchar(100));

insert into #EmployeeList
select Id,FirstName,LastName
from Employee

delete from #EmployeeList
where FirstName like 'A%'

select sum(TotalPrice) as TotalPrice, el.FirstName,el.LastName
from #EmployeeList el
inner join [Order] o on o.EmployeeId = el.EmployeeID
group by el.FirstName,el.LastName
order by el.FirstName,el.LastName


--samo tuka postoi , ako vo novo query pustime nema da raboti
select * from #EmployeeList





----built in functions

select FirstName,
Left(FirstName,3) as LeftFunction,
Right(FirstName,3) as RightFunction,
Len (FirstName) as LenFunction,
Substring(FirstName,1,3) as SubstringFunction,
Replace (FirstName,'Ale-','X-') as ReplaceFunction
from Employee


--------

-- vezba 1

Declare @FirstName nvarchar(100)
set @FirstName = 'Aleksandar'

select @FirstName

select * 
from Employee e
where e.FirstName = @FirstName

-- vezba 2

create Table #EmployeeList2	
(EmployeeId int, DateOfBirth date);

insert into #EmployeeList2
select Id,DateOfBirth
from Employee

select *
from #EmployeeList2 el2
inner join Employee e on e.Id= el2.EmployeeID
where e.Gender = 'M' and e.FirstName like 'A%'



select LastName,Len(LastName) as length
from #EmployeeList2 el2
inner join Employee e on e.Id = el2.EmployeeId
where Len( e.LastName) = 7


-- scalar functions
-- mora dbo.

Create function dbo.fn_EmployeeFullName (@EmployeeID int)
returns nvarchar(2000)
as
begin

declare @Result nvarchar(2000)

select @Result = e.FirstName + N' '+ e.LastName
from Employee e
where Id = @EmployeeID

return @Result
End

select *,  dbo.fn_EmployeeFullName(e.Id)
from dbo.Employee e


-- vezba 1

Create function dbo.fn_FormatProductName2(@ProductID int)
returns nvarchar(2000)
as
begin

declare @Result nvarchar(2000)

select @Result = p.Description
from Product p
where Id = @ProductID 

declare @Result2 nvarchar(2000)

select @Result2 =
SUBSTRING(p.Code,2,2) + N'-' +
SUBSTRING(p.Name,Len(p.Name)-2,3) + N'-'+
cast(p.Price as nvarchar(1000))

from Product p
where Id = @ProductID 

return @Result2

End

select *,  dbo.fn_FormatProductName2(p.Id)
from dbo.Product p



-----vezba



select *
from [Order] o
where BusinessEntityId =1 and CustomerId = 4

select * from OrderDetails
where OrderId =1


Create function dbo.fn_Prodazba(@BuisnessEntityID int,@CustomerID int )
returns @output Table (ProductName nvarchar(100), TotalQuantity int, TotalPrice int)
as
begin



insert @output 
select p.Name,sum(Quantity) as TotalQuantity,sum(TotalPrice) as TotalPrice
from [Order] o
inner join BusinessEntity b on b.id = o.BusinessEntityId
inner join Customer c on c.id = o.CustomerId
inner join OrderDetails od on od.OrderId = o.Id
inner join Product p on p.Id = od.ProductId
where c.id = @CustomerID and b.id = @BuisnessEntityID
group by p.Name


return 

End