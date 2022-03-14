SELECT EmployeeID
FROM Orders;

-- gruppiert nach EmployeeID
SELECT EmployeeID, COUNT(*)
FROM Orders
GROUP BY EmployeeID;


-- gruppiert nach EmployeeID, welche mehr als 100 Vorkommen haben
SELECT EmployeeID, COUNT(*)
FROM Orders
GROUP BY EmployeeID
HAVING COUNT(*) > 100;


--- Sucht die maximale Anzahl eines Produkts in einer Bestellung
SELECT ProductID, MAX(Quantity) AS Anzahl
FROM [Order Details]
GROUP BY ProductID
ORDER BY Anzahl DESC;


-- zählt zusammen, wie oft jedes Produkt bestellt wurde
SELECT ProductID, SUM(Quantity) AS Anzahl
FROM [Order Details]
GROUP BY ProductID
ORDER BY Anzahl DESC;

-- wie oft hat ein Kunde (CustomerID) bestellt?
SELECT CustomerID, COUNT(*) AS AnzahlBestellungen
FROM Orders
GROUP BY CustomerID;

-- welche Kunden haben mehr als 10 Bestellungen getätigt?
SELECT CustomerID, COUNT(*) AS AnzahlBestellungen
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 10;

























