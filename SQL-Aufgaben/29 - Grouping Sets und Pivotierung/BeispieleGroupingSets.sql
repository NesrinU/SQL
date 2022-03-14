-- Beispiele Grouping Sets und Pivotierung
USE TSQL2012;
GO

-- Tabelle 
SELECT * FROM Sales.Orders;

-- 1. Gesamtzahl aller Bestellungen
SELECT COUNT(*)
FROM Sales.Orders o;

-- 2. Gesamtzahl der Bestellungen pro shipperid
SELECT COUNT(*)
FROM Sales.Orders o
GROUP BY shipperid;

-- 3. Alle Bestellungen pro Jahr
SELECT YEAR(OrderDate) Jahr, COUNT(*) Anzahl
FROM Sales.Orders
GROUP BY YEAR(orderdate);

-- 4. Alle Bestellungen pro shipperid und pro Jahr
SELECT YEAR(OrderDate) Jahr,
		shipperid,  COUNT(*) Anzahl
FROM Sales.Orders
GROUP BY shipperid,  YEAR(orderdate);

-- Alle Abfragen von 1 bis 4 kombiniert
SELECT NULL AS Jahr, NULL AS Versender, COUNT(*) Anzahl
FROM Sales.Orders o
UNION ALL
SELECT NULL, shipperid Versender, COUNT(*)
FROM Sales.Orders o
GROUP BY shipperid
UNION ALL
SELECT YEAR(OrderDate) Jahr, NULL, COUNT(*)
FROM Sales.Orders
GROUP BY YEAR(orderdate)
UNION ALL
SELECT YEAR(OrderDate) Jahr,
		shipperid,  COUNT(*)
FROM Sales.Orders
GROUP BY shipperid,  YEAR(orderdate);


-- Mit Grouping Sets
SELECT YEAR(o.orderdate) Jahr, o.shipperid, COUNT(*) Anzahl
FROM Sales.Orders o
GROUP BY
	GROUPING SETS(
					(), 
					(o.shipperid), 
					(YEAR(o.orderdate)), 
					(o.shipperid, YEAR(o.orderdate))
					);

-- Mit CUBE
SELECT YEAR(o.orderdate) Jahr, o.shipperid, COUNT(*) Anzahl
FROM Sales.Orders o
GROUP BY
	CUBE (o.shipperid, YEAR(o.orderdate));

-- Mit ROLLUP
SELECT YEAR(o.orderdate) Jahr, o.shipperid, COUNT(*) Anzahl
FROM Sales.Orders o
GROUP BY
	ROLLUP (o.shipperid, YEAR(o.orderdate));

SELECT YEAR(o.orderdate) Jahr, o.shipperid, COUNT(*) Anzahl,
	GROUPING(Year(o.orderdate)) GrpDate, 
	GROUPING(o.shipperid) GrpShipper,
	GROUPING_ID(Year(o.orderdate), o.shipperid) GrpID
FROM Sales.Orders o
GROUP BY
	ROLLUP (YEAR(o.orderdate), o.shipperid);
