/*5.Create stored procedures to do the following:
a.	Get the monthly bill for the customer. Either by entering their name or phone number.
i.	Each call is listed individually on the bill, including destination country name, length of call, time of call, and the cost of the call.*/ 



CREATE  PROCEDURE dbo.getCustomerBillDetail
(@from_tel numeric (38,0)=0,
 @fname varchar (50)='x',
 @lname varCHAR(50) = 'x',
 @month date )
AS 
      SELECT        T3.telephone, T3.fname, T3.lname, EOMONTH(T1.call_date) AS Month, call_codes.[Country Name], T1.to_tel, T1.call_date, T1.call_time / 60.00 AS [Call Time], dbo.ConvertToTime(T1.call_time) AS Expr1, 
                         
						 dbo.GetPrice(T1.from_code, T1.to_code, T3.serviceId, T1.call_date, T1.call_time, T1.duration) AS [Amount Due]
FROM            calls AS T1 INNER JOIN
                         call_codes AS T2 ON T1.from_code = T2.[Calling Code] INNER JOIN
                         PeakPeriodByService AS T4 ON T1.from_code = T4.CountryCode INNER JOIN
                         Customers AS T3 ON T1.from_tel = T3.telephone AND T4.ServiceId = T3.serviceId INNER JOIN
                         call_codes ON T1.to_code = call_codes.[Calling Code]
WHERE      ((T3.telephone = @from_tel) Or (T3.fname=@fname and t3.lname=@lname)) AND (EOMONTH(T1.call_date) = @month)
       

exec dbo.getCustomerBillDetail @from_tel = 7206840649,@month='1/31/2008'

--ii.The total cost of all calls made during the month is listed as the “Amount Duev
CREATE  PROCEDURE dbo.getCustomerBillSummary
(@from_tel numeric (38,0)=0,
 @fname varchar (50)='x',
 @lname varCHAR(50) = 'x',
 @month date )

AS 
SELECT        T3.telephone, T3.fname, T3.lname, SUM(dbo.GetPrice(T1.from_code, T1.to_code, T3.serviceId, T1.call_date, T1.call_time, T1.duration)) AS [Amount Due], EOMONTH(T1.call_date) AS Month
FROM            calls AS T1 INNER JOIN
                         call_codes AS T2 ON T1.from_code = T2.[Calling Code] INNER JOIN
                         PeakPeriodByService AS T4 ON T1.from_code = T4.CountryCode INNER JOIN
                         Customers AS T3 ON T1.from_tel = T3.telephone AND T4.ServiceId = T3.serviceId
GROUP BY T3.telephone, T3.fname, T3.lname, EOMONTH(T1.call_date)
HAVING       ((T3.telephone = @from_tel) Or (T3.fname=@fname and t3.lname=@lname)) AND (EOMONTH(T1.call_date) = @month)

exec dbo.getCustomerBillSummary @from_tel = 7206840649,@month='1/31/2008'

--b.Get the monthly summary for a specified service. 
Create proc dbo.getServiceSummary
(@month date,
@service nvarchar (50)) 

as

SELECT        EOMONTH(T1.call_date) AS Month, Services.ServiceName, call_codes_1.[Country Name] AS [From Country], call_codes.[Country Name] AS [To Country], SUM(T1.call_time / 60.00) AS [Call Time]
FROM            calls AS T1 INNER JOIN
                         call_codes AS T2 ON T1.from_code = T2.[Calling Code] INNER JOIN
                         PeakPeriodByService AS T4 ON T1.from_code = T4.CountryCode INNER JOIN
                         Customers AS T3 ON T1.from_tel = T3.telephone AND T4.ServiceId = T3.serviceId INNER JOIN
                         call_codes ON T1.to_code = call_codes.[Calling Code] INNER JOIN
                         Services ON T4.ServiceId = Services.ServiceId INNER JOIN
                         call_codes AS call_codes_1 ON T1.from_code = call_codes_1.[Calling Code]
GROUP BY EOMONTH(T1.call_date), Services.ServiceName, call_codes_1.[Country Name], call_codes.[Country Name]
HAVING        (EOMONTH(T1.call_date) = @month) AND (Services.ServiceName = @service)
ORDER BY [From Country], [To Country], [Call Time]

exec  dbo.getServiceSummary '1/31/2008','spectra'

--c.	Get the call log for a user in a specified period.

create procedure dbo.callLogPeriod
(@from_tel numeric (38,0),
  @Frommonth date, 
 @tomonth date)

 as
 SELECT        T3.telephone, T3.fname, T3.lname, call_codes.[Country Name], T1.to_tel, T1.call_date, T1.call_time / 60.00 AS [Call Time], dbo.ConvertToTime(T1.call_time) AS Expr1, dbo.GetPrice(T1.from_code, T1.to_code, 
                         T3.serviceId, T1.call_date, T1.call_time, T1.duration) AS [Amount Due]
FROM            calls AS T1 INNER JOIN
                         call_codes AS T2 ON T1.from_code = T2.[Calling Code] INNER JOIN
                         PeakPeriodByService AS T4 ON T1.from_code = T4.CountryCode INNER JOIN
                         Customers AS T3 ON T1.from_tel = T3.telephone AND T4.ServiceId = T3.serviceId INNER JOIN
                         call_codes ON T1.to_code = call_codes.[Calling Code]
WHERE        (T1.call_date BETWEEN @Frommonth AND @tomonth ) AND (T3.telephone = @from_tel)

exec  dbo.callLogPeriod 7206840649,'1/10/2008','4/10/2008'

--d.	Get the monthly commission for sales people.

create procedure dbo.getMonthlyCommission
(@month date,
@salerepid int)

as
SELECT        EOMONTH(T1.call_date) AS Month, T5.SalerepID, SUM(dbo.GetPrice(T1.from_code, T1.to_code, T3.serviceId, T1.call_date, T1.call_time, T1.duration) * T5.CommissionPct) AS Commision
FROM            calls AS T1 INNER JOIN
                         call_codes AS T2 ON T1.from_code = T2.[Calling Code] INNER JOIN
                         PeakPeriodByService AS T4 ON T1.from_code = T4.CountryCode INNER JOIN
                         Customers AS T3 ON T1.from_tel = T3.telephone AND T4.ServiceId = T3.serviceId INNER JOIN
                         Salesrep_Info AS T5 ON T3.rowId = T5.CustomerId
GROUP BY EOMONTH(T1.call_date), T5.SalerepID
HAVING        (EOMONTH(T1.call_date) = @month) AND (T5.SalerepID = @salerepid)

exec dbo.getMonthlyCommission '1/31/2008',12 

--e.	Get a report on top countries called for each service and how many calls where placed to that country.

create proc dbo.topCountries
(@serviceName varchar (50))
as

SELECT        Services.ServiceName, call_codes_1.[Country Name] AS Expr2, COUNT(T1.rowId) AS Expr1
FROM            calls AS T1 INNER JOIN
                         call_codes AS T2 ON T1.from_code = T2.[Calling Code] INNER JOIN
                         PeakPeriodByService AS T4 ON T1.from_code = T4.CountryCode INNER JOIN
                         Customers AS T3 ON T1.from_tel = T3.telephone AND T4.ServiceId = T3.serviceId INNER JOIN
                         call_codes ON T1.to_code = call_codes.[Calling Code] INNER JOIN
                         call_codes AS call_codes_1 ON T1.to_code = call_codes_1.[Calling Code] INNER JOIN
                         Services ON T4.ServiceId = Services.ServiceId
GROUP BY call_codes_1.[Country Name], Services.ServiceName
HAVING        (Services.ServiceName = @serviceName)
ORDER BY Expr1 DESC

exec dbo.topCountries'voip'

--f.Rank the services according to the total times spent on calls during the month.
create proc spentTimesMonth
(@month date)
as

SELECT       RANK() OVER (ORDER BY SUM(T1.call_time / 60.00) DESC) AS Rank, EOMONTH(T1.call_date) AS Month, Services.ServiceName, SUM(T1.call_time / 60.00) AS [Call Time]
FROM            calls AS T1 INNER JOIN
                         call_codes AS T2 ON T1.from_code = T2.[Calling Code] INNER JOIN
                         PeakPeriodByService AS T4 ON T1.from_code = T4.CountryCode INNER JOIN
                         Customers AS T3 ON T1.from_tel = T3.telephone AND T4.ServiceId = T3.serviceId INNER JOIN
                         call_codes ON T1.to_code = call_codes.[Calling Code] INNER JOIN
                         Services ON T4.ServiceId = Services.ServiceId INNER JOIN
                         call_codes AS call_codes_1 ON T1.from_code = call_codes_1.[Calling Code]
GROUP BY EOMONTH(T1.call_date), Services.ServiceName
HAVING        (EOMONTH(T1.call_date) = @month)

exec spentTimesMonth '12/31/2007'

--g.Get the top 3 hours for a specified day according to the time spent on calls.

create proc dbo.top3TimeSpentForDay
(@date date)
as

SELECT        TOP (3) T1.call_date, DATEPART(hour, dbo.ConvertToTime(T1.call_time)) AS Hour, COUNT(T1.rowId) AS AmountOfCalls
FROM            calls AS T1 INNER JOIN
                         call_codes AS T2 ON T1.from_code = T2.[Calling Code] INNER JOIN
                         PeakPeriodByService AS T4 ON T1.from_code = T4.CountryCode INNER JOIN
                         Customers AS T3 ON T1.from_tel = T3.telephone AND T4.ServiceId = T3.serviceId INNER JOIN
                         call_codes ON T1.to_code = call_codes.[Calling Code]
GROUP BY DATEPART(hour, dbo.ConvertToTime(T1.call_time)), T1.call_date
HAVING        (T1.call_date = @date)
ORDER BY AmountOfCalls DESC

exec dbo.top3TimeSpentForDay '12/10/2007'

/*h.	Add a customer.

i.	Make sure to do data validation.

ii.	Remember to add the service and the sales rep and the commission*/

--pending

--i.	Change the customer service.

Create proc dbo.changeCustomerService
 
 (@NewService int ,
@CustomerId int )
as

UPDATE Customers
SET
ServiceId = @NewService
WHERE RowId = @CustomerId

exec dbo.changeCustomerService 1,1 
