--Aufgabe 5
--Befassen Sie sich nun mit Northwind-Datenbank
USE Northwind;

--Tabelle Orders:
SELECT *
FROM Orders;

--1) Welches Land hat die meisten Kunden?
SELECT TOP 1 
ShipCountry AS Land, COUNT(DISTINCT CustomerID) AS [Kunden]
FROM Orders
GROUP BY ShipCountry
ORDER BY COUNT(DISTINCT CustomerID) DESC;

--2) Wie viel Fracht (Freight) gab es im Jahr 1997?
SELECT COUNT(Freight) AS [Fracht]
FROM Orders
WHERE YEAR(OrderDate) = 1997;

--3) Wie viele unterschiedliche Kunden gab es im Jahr 1998?
SELECT COUNT(DISTINCT CustomerID) AS [Kunden]
FROM Orders
WHERE YEAR(OrderDate) = 1998;

--4) Wie viel Fracht haben die jeweiligen Lieferanten (ShipVia) pro Jahr in einem Dezember befördert?
???
SELECT 
	ShipVia AS Lieferant, 
	MONTH(OrderDate) AS Datum,
	COUNT(Freight)				AS Fracht
FROM Orders
WHERE MONTH(OrderDate) = 12
GROUP BY ShipVia;

--Tabelle Products:
SELECT *
FROM Products;

--1) Wie viele Kategorien von Produkten gibt es?
SELECT COUNT(DISTINCT CategoryID)
FROM Products;

--2) Welche Lieferanten liefern Artikel aus der Kategorie 6?
SELECT SupplierID
FROM Products
WHERE CategoryID = 6;

--3) Welche ist die im Durchschnitt teuerste Kategorie?
SELECT TOP 1
	CategoryID, AVG(UnitPrice) AS [Durchschnitt-Preis]
FROM Products
GROUP BY CategoryID
ORDER BY AVG(UnitPrice) DESC;
--ODER
SELECT 
	CategoryID, 
	AVG(UnitPrice) AS [Durchschnitt-Preis]
FROM Products
GROUP BY CategoryID
HAVING AVG(UnitPrice) = MAX(AVG(UnitPrice));

--Tabelle Employees:
SELECT *
FROM Employees;

--1) Wie viele Arbeiter wurden im Jahr 1994 angestellt?
SELECT COUNT(EmployeeID)
FROM Employees
WHERE YEAR(HireDate) = 1994;

--Tabelle Order Details
SELECT *
FROM [Order Details];

--1) Was ist die durchschnittliche Bestellmenge?
SELECT AVG(Quantity)
FROM [Order Details];

--2) Welche Bestellung hatte die meisten Posten?
SELECT TOP 1
OrderID, COUNT(ProductID) AS Produkt_Zahl
FROM [Order Details]
GROUP BY OrderID
ORDER BY Produkt_Zahl DESC;

--3) Welche Bestellung hatte den teuersten Posten?
SELECT TOP 1
OrderID, MAX(UnitPrice) AS Teuerer_Preis
FROM [Order Details]
GROUP BY OrderID
ORDER BY Teuerer_Preis DESC;

--4) Welche Bestellung hatte die größte Anzahl an Einzelartikeln?
SELECT TOP 1
OrderID, COUNT(DISTINCT ProductID) AS Produkt
FROM [Order Details]
GROUP BY OrderID
ORDER BY Produkt DESC;