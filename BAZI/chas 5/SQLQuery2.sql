create procedure dbo.Customer (@Name nvarchar(100),@AccountNumber nvarchar(50),@City nvarchar(100),@RegionName nvarchar(100),@isActive bit)
as
begin

insert into dbo.Customer (Name,AccountNumber,City,RegionName,isActive)
values (@Name,@AccountNumber,@City,@RegionName,@isActive)

select count(*) as TotalCutomersFirstLetter
from dbo.Customer
where substring(Name,1,1)=substring(@name,1,1)


select count(*) as CustomersInRegion
from dbo.Customer
where  RegionName = @RegionName

end
go



--------




create procedure dbo.CreateOrder (@CustomerId int, @BuisnessEntityId int, @OrderDate date, @Status bit, @EmployeeId int )
as
begin

insert into dbo.[Order] (CustomerId,BusinessEntityId,OrderDate,Status,EmployeeId)
values (@CustomerId,@BuisnessEntityId,@OrderDate , @Status,@EmployeeId  )

--Declare @OrderDate date = '2019.01.01'
--Declare @Status bit = 1
--declare @CustomerId int = 4
--declare @BuisnessEntityId int = 1

select count(*) as TotalOrders
from dbo.[Order] o
where o.CustomerId = @CustomerId 

select sum(TotalPrice) as TotalPrice
from dbo.[Order] o
where o.CustomerId = @CustomerId and o.BusinessEntityId = @BuisnessEntityId



end
go



select * from [Order]

exec dbo.CreateOrder 
@CustomerId = 4,
@BuisnessEntityId = 1,
@OrderDate = '2019.01.01',
@Status = 1,
@EmployeeId = 61


-----


select * from OrderDetails


-- expected varibles
--declare @OrderId int = 4206
--declare @ProductId int = 2
--declare @Quantity int =150

--internal variables

--declare @price decimal(18,2)


create procedure dbo.CreateOrderDetail(@OrderId int,@ProductId int,@Quantity int)
as
begin


declare @price decimal(18,2)
declare @TotalPrice decimal(18,2)


Set @price =
(select Price
from dbo.Product
where id = @ProductId)

set @TotalPrice = 
(
select sum(d.Quantity*d.Price)
from dbo.OrderDetails d
where OrderId= @OrderId
)

begin try
insert into dbo.OrderDetails(OrderId,ProductId,Quantity,Price)
values (@OrderId,@ProductId , @Quantity, @price )
end try

begin catch
 print 'greshka'
end catch 

select @price

select top 10 *
 from dbo.OrderDetails
order by id desc


insert into dbo.OrderDetails(OrderId,ProductId,Quantity,Price)
values (@OrderId,@ProductId,@Quantity,@price)

select *
from dbo.OrderDetails d
where OrderId = @OrderId


update o set totalprice = @TotalPrice 
from [Order] o 
where id =@OrderId


end
go

exec dbo.CreateOrderDetail
@OrderId  = 4206,
@ProductId  = 2 ,
@Quantity  =150



--------catch greshki

create procedure usp_ExampleProc
as
Select 1/0;
go 

begin try
execute usp_ExampleProc
end try
begin catch 
    print  'ima greshka'
	--ERROR_NUMBER() as ErrorNumber,
	--Error_Severity() as ErrorSeverity,

end catch