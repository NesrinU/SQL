--Aufgabe 4
--Befassen Sie sich nun mit der tblDHCPLog in der TeachSQL-Datenbank
USE TeachSQL;

SELECT *
FROM tblDHCPLog;

--1.	Wie viele Adressen hat der DHCP-Server in der protokollierten Zeit insgesamt ausgeliefert?
SELECT COUNT(IP) AS [IP-Adressen]
FROM tblDHCPLog;

--2.	Wie viele verschiedene Rechner haben sich von diesem DHCP-Server eine IP-Adresse geholt?
SELECT COUNT(DISTINCT(SRCMAC)) AS [Rechner]
FROM tblDHCPLog;

--3.	Wie viele verschiedene IP-Adressen wurden von diesem DHCP-Server vergeben?
SELECT COUNT(DISTINCT(IP)) AS [IP-Adressen]
FROM tblDHCPLog;

--4.	Wie oft hat sich jeder Rechner eine IP-Adresse vom DHCP-Server geben lassen?
SELECT SRCMAC AS [Rechner], COUNT(IP) AS [IP-Adressen]
FROM tblDHCPLog
GROUP BY SRCMAC;

--5.	An wie viele verschiedene Rechner wurde jede IP-Adresse jeweils vergeben?
SELECT IP AS [IP-Adressen], COUNT(DISTINCT(SRCMAC)) AS [Rechner]
FROM tblDHCPLog
GROUP BY IP;

--6.	Welche verschiedenen Lease-Zeiten wurden vom DHCP-Server verwendet und wie oft wurde eine IP für diese Lease-Zeit vergeben?
SELECT LeaseDate AS [Lease-Zeiten], COUNT(IP) AS [IP-Adressen]
FROM tblDHCPLog
GROUP BY LeaseDate;

--7.	Ermitteln Sie Datum und Uhrzeit der ersten und letzten Vergabe einer IP-Adresse?
SELECT IP AS [IP-Adressen], MAX(LeaseDate) AS [Letzte-Lease-Zeite], MIN(LeaseDate) AS [Erste-Lease-Zeite]
FROM tblDHCPLog
GROUP BY IP;

--8.	Wie viele Adressen wurden pro Monat vergeben?
SELECT DATENAME(MONTH, LeaseDate) AS MONAT, COUNT(IP) AS [IP-Adressen]
FROM tblDHCPLog
GROUP BY DATENAME(MONTH, LeaseDate);
--ODER
SELECT DATENAME(MONTH, LeaseDate) AS Monat, DATENAME(YEAR, LeaseDate) AS Jahr, COUNT(IP) AS [IP-Adressen]
FROM tblDHCPLog
GROUP BY DATENAME(MONTH, LeaseDate), DATENAME(YEAR, LeaseDate), MONTH(LeaseDate)
ORDER BY Jahr, MONTH(LeaseDate);

--9.	Wie viele Adressen wurden pro Wochentag vergeben?
SELECT DATENAME(DW, LeaseDate) AS MONAT, COUNT(IP) AS [IP-Adressen]
FROM tblDHCPLog
GROUP BY DATENAME(DW, LeaseDate);

--10.	Welche der IP-Adressen wurde im Verlauf der Zeit an jeden Rechner mind. ein Mal vergeben?
SELECT COUNT(DISTINCT(SRCMAC)) AS [Rechner]
FROM tblDHCPLog;
--UND
SELECT IP AS [IP-Adressen],
COUNT(DISTINCT SRCMAC) AS [Rechner]
FROM tblDHCPLog
GROUP BY IP
HAVING COUNT(DISTINCT SRCMAC) = 16;

--ODER
SELECT IP AS [IP-Adressen], 
COUNT(DISTINCT SRCMAC) AS [Rechner]
FROM tblDHCPLog
GROUP BY IP
HAVING COUNT(DISTINCT SRCMAC) = (SELECT COUNT(DISTINCT(SRCMAC)) AS [Rechner]
FROM tblDHCPLog);


