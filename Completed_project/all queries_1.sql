--A. 1
SELECT        T3.telephone, T3.fname, T3.lname, EOMONTH(T1.call_date) AS Month, call_codes.[Country Name], T1.to_tel, T1.call_date, T1.call_time / 60.00 AS [Call Time], dbo.ConvertToTime(T1.call_time) AS Expr1, 
                         dbo.GetPrice(T1.from_code, T1.to_code, T3.serviceId, T1.call_date, T1.call_time, T1.duration) AS [Amount Due]
FROM            calls AS T1 INNER JOIN
                         call_codes AS T2 ON T1.from_code = T2.[Calling Code] INNER JOIN
                         PeakPeriodByService AS T4 ON T1.from_code = T4.CountryCode INNER JOIN
                         Customers AS T3 ON T1.from_tel = T3.telephone AND T4.ServiceId = T3.serviceId INNER JOIN
                         call_codes ON T1.to_code = call_codes.[Calling Code]
WHERE        (T3.telephone = 7206840649) AND (EOMONTH(T1.call_date) = '1/31/2008')

--A. 2
SELECT        T3.telephone, T3.fname, T3.lname, SUM(dbo.GetPrice(T1.from_code, T1.to_code, T3.serviceId, T1.call_date, T1.call_time, T1.duration)) AS [Amount Due], EOMONTH(T1.call_date) AS Month
FROM            calls AS T1 INNER JOIN
                         call_codes AS T2 ON T1.from_code = T2.[Calling Code] INNER JOIN
                         PeakPeriodByService AS T4 ON T1.from_code = T4.CountryCode INNER JOIN
                         Customers AS T3 ON T1.from_tel = T3.telephone AND T4.ServiceId = T3.serviceId
GROUP BY T3.telephone, T3.fname, T3.lname, EOMONTH(T1.call_date)
HAVING        (T3.telephone = 7206840649) AND (EOMONTH(T1.call_date) = '1/31/2008')


--B
SELECT        EOMONTH(T1.call_date) AS Month, Services.ServiceName, call_codes_1.[Country Name] AS [From Country], call_codes.[Country Name] AS [To Country], SUM(T1.call_time / 60.00) AS [Call Time]
FROM            calls AS T1 INNER JOIN
                         call_codes AS T2 ON T1.from_code = T2.[Calling Code] INNER JOIN
                         PeakPeriodByService AS T4 ON T1.from_code = T4.CountryCode INNER JOIN
                         Customers AS T3 ON T1.from_tel = T3.telephone AND T4.ServiceId = T3.serviceId INNER JOIN
                         call_codes ON T1.to_code = call_codes.[Calling Code] INNER JOIN
                         Services ON T4.ServiceId = Services.ServiceId INNER JOIN
                         call_codes AS call_codes_1 ON T1.from_code = call_codes_1.[Calling Code]
GROUP BY EOMONTH(T1.call_date), Services.ServiceName, call_codes_1.[Country Name], call_codes.[Country Name]
HAVING        (EOMONTH(T1.call_date) = '12/31/2007') AND (Services.ServiceName = 'Spectra')
ORDER BY [From Country], [To Country], [Call Time]


--C
SELECT        T3.telephone, T3.fname, T3.lname, call_codes.[Country Name], T1.to_tel, T1.call_date, T1.call_time / 60.00 AS [Call Time], dbo.ConvertToTime(T1.call_time) AS Expr1, dbo.GetPrice(T1.from_code, T1.to_code, 
                         T3.serviceId, T1.call_date, T1.call_time, T1.duration) AS [Amount Due]
FROM            calls AS T1 INNER JOIN
                         call_codes AS T2 ON T1.from_code = T2.[Calling Code] INNER JOIN
                         PeakPeriodByService AS T4 ON T1.from_code = T4.CountryCode INNER JOIN
                         Customers AS T3 ON T1.from_tel = T3.telephone AND T4.ServiceId = T3.serviceId INNER JOIN
                         call_codes ON T1.to_code = call_codes.[Calling Code]
WHERE        (T1.call_date BETWEEN CONVERT(DATETIME, '2008-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2008-12-31 00:00:00', 102)) AND (T3.telephone = 5623401075)


--D
SELECT        EOMONTH(T1.call_date) AS Month, T5.SalerepID, SUM(dbo.GetPrice(T1.from_code, T1.to_code, T3.serviceId, T1.call_date, T1.call_time, T1.duration) * T5.CommissionPct) AS Commision
FROM            calls AS T1 INNER JOIN
                         call_codes AS T2 ON T1.from_code = T2.[Calling Code] INNER JOIN
                         PeakPeriodByService AS T4 ON T1.from_code = T4.CountryCode INNER JOIN
                         Customers AS T3 ON T1.from_tel = T3.telephone AND T4.ServiceId = T3.serviceId INNER JOIN
                         Salesrep_Info AS T5 ON T3.rowId = T5.CustomerId
GROUP BY EOMONTH(T1.call_date), T5.SalerepID
HAVING        (EOMONTH(T1.call_date) = '1/31/2008') AND (T5.SalerepID = 12)


--E
SELECT        Services.ServiceName, call_codes_1.[Country Name] AS Expr2, COUNT(T1.rowId) AS Expr1
FROM            calls AS T1 INNER JOIN
                         call_codes AS T2 ON T1.from_code = T2.[Calling Code] INNER JOIN
                         PeakPeriodByService AS T4 ON T1.from_code = T4.CountryCode INNER JOIN
                         Customers AS T3 ON T1.from_tel = T3.telephone AND T4.ServiceId = T3.serviceId INNER JOIN
                         call_codes ON T1.to_code = call_codes.[Calling Code] INNER JOIN
                         call_codes AS call_codes_1 ON T1.to_code = call_codes_1.[Calling Code] INNER JOIN
                         Services ON T4.ServiceId = Services.ServiceId
GROUP BY call_codes_1.[Country Name], Services.ServiceName
HAVING        (Services.ServiceName = 'VOIP')
ORDER BY Expr1 DESC


--F
SELECT       RANK() OVER (ORDER BY SUM(T1.call_time / 60.00) DESC) AS Rank, EOMONTH(T1.call_date) AS Month, Services.ServiceName, SUM(T1.call_time / 60.00) AS [Call Time]
FROM            calls AS T1 INNER JOIN
                         call_codes AS T2 ON T1.from_code = T2.[Calling Code] INNER JOIN
                         PeakPeriodByService AS T4 ON T1.from_code = T4.CountryCode INNER JOIN
                         Customers AS T3 ON T1.from_tel = T3.telephone AND T4.ServiceId = T3.serviceId INNER JOIN
                         call_codes ON T1.to_code = call_codes.[Calling Code] INNER JOIN
                         Services ON T4.ServiceId = Services.ServiceId INNER JOIN
                         call_codes AS call_codes_1 ON T1.from_code = call_codes_1.[Calling Code]
GROUP BY EOMONTH(T1.call_date), Services.ServiceName
HAVING        (EOMONTH(T1.call_date) = '12/31/2007')

--G
SELECT        TOP (3) T1.call_date, DATEPART(hour, dbo.ConvertToTime(T1.call_time)) AS Hour, COUNT(T1.rowId) AS AmountOfCalls
FROM            calls AS T1 INNER JOIN
                         call_codes AS T2 ON T1.from_code = T2.[Calling Code] INNER JOIN
                         PeakPeriodByService AS T4 ON T1.from_code = T4.CountryCode INNER JOIN
                         Customers AS T3 ON T1.from_tel = T3.telephone AND T4.ServiceId = T3.serviceId INNER JOIN
                         call_codes ON T1.to_code = call_codes.[Calling Code]
GROUP BY DATEPART(hour, dbo.ConvertToTime(T1.call_time)), T1.call_date
HAVING        (T1.call_date = CONVERT(DATETIME, '2008-01-07 00:00:00', 102))
ORDER BY AmountOfCalls DESC

--H


--I
Declare @NewService int = 1,
@CustomerId int = 1
UPDATE Customers
SET
ServiceId = @NewService
WHERE RowId = @CustomerId