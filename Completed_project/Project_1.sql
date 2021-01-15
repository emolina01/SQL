
/*3.Insert data from the word documents*/

CREATE TABLE Customers (rowId int identity(1,1) not null, 
						fname varchar(50) NOT NULL,
                        lname varchar(50) NOT NULL,
                        addressline1 NVARCHAR(60) NOT NULL,
						city nvarchar(60) not null,
						state nvarchar(60) not null,
						zip nvarchar(60) not null,
						country nvarchar(60) not null,
						telephone NVARCHAR(25) NOT NULL,
						service CHAR (20) NOT NULL);

INSERT  INTO dbo.Customers
        (fname,lname,addressline1,city, state, zip, country, telephone,[service])

VALUES  ('Randy','Jones'		,'404 S Washington Street',  'Houston',  'TX', '77020', 'USA','7139375437','Spectra'),
     ('David'	, 'Stephenson'	,'2090 165th Street', 'Bloomfield', 'CN',  '06832', 'USA',' 8606643148', 'Deluxe' ),
	 ('Thomas'	,' Tripp'		,'110 N Madison Avenue', 'New York', 'NY',  '10156', 'USA',' 2129695507', ' VOIP' ),
	  ('Mary'	,' Manning'		,'508 W Jackson Avenue', 'San Francisco', 'CA', '94138', 'USA',' 4154715025','   Budget'),
	  ('Robert'	,' McCracken'	,' 2236 W Highway 1', 'Providence', 'RI', '02911', 'USA','	 4012933377','  Premium'),
	 ('Dale'	,' Malone'		,' 5233 Forest Avenue', 'Naples', 'FL', '35107', 'USA','	 7863858400','  Spectra'),
	 ('Harold'	,' Simpson '	,'1816 W Taylor Street', 'Chicago', 'IL', '60647', 'USA','	 7739866739','  Deluxe'),
	 ('William'	, 'Thurston'	,' 506 S Dogwood Drive', 'Denver', 'CO', '80204', 'USA','	 7206840649','  VOIP'),
	 ('Mike'	,' Tucker'		,' 8011 S 22nd Street', 'Philadelphia', 'PA', '19148', 'USA','	  2158144236','  Budget'),
	 ('Conrad'	,' Nolte'		,' 704 Orchard Place', 'Cedar Rapids', 'IA', '52497', 'USA','	  3194932947',' 	 Premium'),
	 ('Robert'	,' Olden',' 220 N 28th Street', 'St. Louis', 'MO', '63114', 'USA','	  5573013399', ' Spectra'),
	 ('Theresa'	,' Palm',' 1734 Hemlock Avenue', 'Savannah', 'GA', '31414', 'USA','	  9124429540',' 	  Spectra'),
	  ('Alfred'	,' Kalmbach',' 22 Dolmkoster Strasse', '', 'Hamburg', '6511', 'GERMANY','  3442024502',' 	 Spectra'),
	  ('Anna'	,' Stein',' 333 Frederik Strasse', '', 'Berlin', '4451', 'GERMANY','	 3732023454',' 	 GACB'),
	   ('Emil'	,' Aston',' 529 Rue Danton', '', 'Paris', '3294', 'FRANCE','  5623401075',' 	  Spectra'),
	    ('Ewald',' Reynolds',' 8800 Rue Suger', '', 'Nice', '8322', 'FRANCE','	  5921541145','	  GACB'),
		('Helga',' Stover',' 843 Herluf Gade', '', 'Copenhagen', '4400', 'DENMARK','	  8634204255','   Spectra'),
		('Rudolf',' Torpini',' 2373 Via S. Marco', '', 'Rome', '2911',  'ITALY','	 7413134451','  Spectra'),
		('Alberto',' Russo',' 89 Via Portico', '','Florence' ,'4522' ,'ITALY','	 7923411130',' 	 GACB'),
		('Adam',' Smith',' 66A Trowbridge Square','','London', '6725', 'UNITED KINGDOM','  4423401033',' 	  Spectra');

		
CREATE TABLE Salesrep_Info (rowId int identity(1,1) not null, 
							fname varchar(50) NOT NULL,
							lname varchar(50) NOT NULL,
							SalerepID int NOT NULL,
							CommissionPct decimal(5,4) NOT NULL);

	
INSERT  INTO dbo.Salesrep_Info
        (fname,lname,SalerepID,CommissionPct)
		
		VALUES  ('Randy',' Jones',	23,	.08),			
		         ('David',' Stephenson',	12,	.10),
				  ('Thomas',' Tripp',22,.07),
				  ('Mary',' Manning',15,.05),
				  ('Robert',' McCracken',12,.08	),
				   ('Dale',' Malone',	18,		.10	),
				   ('Harold',' Simpson',	23,	.06	),
				   ('William', 'Thurston',	12,	.09	),
				    ('Mike',' Tucker',	18,	.06	),
					 ('Conrad',' Nolte',24,	.09	),
					  ('Robert',' Olden',	22,	.10	),
					  ('Theresa',' Palm',	14,	.05	),
					   ('Alfred',' Kalmbach',15,.07	),
					   ('Anna',' Stein',22,	.10	),
					   ('Emil',' Aston',23,	.09	),
					   ('Ewald',' Reynolds',19,	.10	),
					   ('Helga',' Stover',	19	,.05	),
					   ('Rudolf',' Torpini',	17,	.06	),
					   ('Alberto',' Russo',	17,		.08	),
					   ('Adam',' Smith',	19,	.10	);
		

CREATE TABLE PeakPeriodByService (
                        rowId int identity(1,1) not null, 
						Country NVARCHAR(50) NOT NULL,
                        service CHAR (20) NOT NULL,
                        PeakPeriodStart TIME NOT NULL,
						OffPeakPeriodStart TIME NOT NULL
					
						          );


            INSERT  INTO dbo.PeakPeriodByService
        (Country,service,PeakPeriodStart,OffPeakPeriodStart)
		
		VALUES  ('USA',' Spectra',	'08:00:00','17:00:00'),			
		        ('USA',' Deluxe',	'08:00:00','17:00:00'),
				  ('USA',' VOIP',	'08:00:00','17:00:00'),
				 ('USA',' Budget',	'08:00:00','17:00:00'),
				  ('USA',' Premium',	'08:00:00','17:00:00'),
				  ('GER',' Spectra',	'09:00:00','19:00:00'),
				    ('GER',' GACB',	'09:00:00','19:00:00'),
				   ('FRANCE',' GACB',	'09:00:00','19:00:00'),
				    ('FRANCE',' Spectra',	'09:00:00','19:00:00'),
					 ('Denmark',' Spectra',	'09:00:00','19:00:00'),
					  ('Denmark',' GACB',	'09:00:00','19:00:00'),
					  ('Italy',' GACB',	'09:00:00','19:00:00'),
					   ('Italy','Spectra',	'09:00:00','19:00:00'),
					  ('England','Spectra',	'08:30:00','18:00:00'),
					   ('England','GACB',	'08:30:00','18:00:00'),
					  ('Netherlands','GACB',	'08:30:00','18:00:00'),
					   ('Netherlands','Spectra',	'08:30:00','18:00:00'),
					   ('Spain','GACB',	'09:00:00','17:30:00'),
					   ('Hungary','GACB',	'09:00:00','17:30:00'),
					   ('Austria','GACB',	'09:00:00','17:30:00');




--Create Serive table to Normalize the data from the Customers Table
CREATE TABLE Services(
ServiceId int primary key identity(1,1),
ServiceName varchar(100)
)

Insert into Services(ServiceName)
SELECT        TOP (200) service
FROM            rates
GROUP BY service

--Update the customers table with the correct ServiceId 
UPDATE
    Customers
SET
    Customers.serviceId = Services.ServiceId
FROM
    Customers INNER JOIN
                         Services ON Customers.service = Services.ServiceName

--Update the SalesRep_Info table with the correct CustomerID 
UPDATE
    Salesrep_Info
SET
    Salesrep_Info.CustomerId = Customers.RowId
FROM
 Customers INNER JOIN
                         Salesrep_Info ON Customers.fname = Salesrep_Info.fname AND Customers.lname = Salesrep_Info.lname

--Update the PeakPeriodByService table with the correct ServiceId 
UPDATE
    PeakPeriodByService
SET
    PeakPeriodByService.ServiceId = Services.ServiceId
FROM
    PeakPeriodByService INNER JOIN
                         Services ON PeakPeriodByService.service = Services.ServiceName


--Update the PeakPeriodByService table with the correct CallCode 
UPDATE
    PeakPeriodByService
SET
    PeakPeriodByService.CountryCode = call_codes.[Calling Code]

FROM            PeakPeriodByService INNER JOIN
                         call_codes ON PeakPeriodByService.Country = call_codes.[Country Name]

--Update the rates table with the correct CallCode 
UPDATE
    rates
SET
    rates.CountryCode = call_codes.[Calling Code]

FROM            rates INNER JOIN
                         call_codes ON rates.Country = call_codes.[Country Name]

--Update the rates table with the correct CallCode 
UPDATE
    rates
SET
    rates.ServiceId = Services.ServiceId
FROM
    rates INNER JOIN
                         Services ON rates.service = Services.ServiceName



--Add foreign Keys to join all tables
ALTER TABLE calls
ADD CONSTRAINT FK_FromCode_CallingCode FOREIGN KEY (from_code) REFERENCES call_codes([Calling Code]);

ALTER TABLE calls
ADD CONSTRAINT FK_ToCode_CallingCode FOREIGN KEY (to_code) REFERENCES call_codes([Calling Code]);

ALTER TABLE Customers
ADD UNIQUE (telephone)

ALTER TABLE calls
ADD CONSTRAINT FK_FromTel_telephone FOREIGN KEY (from_tel) REFERENCES Customers(telephone);

ALTER TABLE Salesrep_Info
ADD CONSTRAINT FK_Name_Customers FOREIGN KEY (CustomerId) REFERENCES Customers(RowId);

ALTER TABLE Customers
ADD CONSTRAINT FK_Services_Customers FOREIGN KEY (ServiceId) REFERENCES Services(ServiceId) ON UPDATE CASCADE;

ALTER TABLE PeakPeriodByService
ADD CONSTRAINT FK_Services_Peaks FOREIGN KEY (ServiceId) REFERENCES Services(ServiceId) ON UPDATE CASCADE;


