--Aufgabe 2 
--Es sind die folgenden Tabellen gegeben:
SELECT *
FROM tblDevice;

SELECT *
FROM tblVendor;

--Die Spalte VendorID in der Tabelle tblDevice ist der Fremdschlüssel für die Tabelle tblVendor. Das 
--entsprechende Skript finden Sie in der Freigabe zum Unterricht (Devices.sql). 
--Beantworten Sie die folgenden Fragen zu den Tabellen: 
--1. Verwenden Sie INNER JOIN, um zu jedem Gerät seinen Namen, seinen Ort sowie den Namen
--des Herstellers auszugeben.
SELECT d.ID, v.Name AS Hersteller, d.Name AS Device, d.Location AS Ort
FROM tblDevice AS d
INNER JOIN tblVendor AS v
ON d.VendorID = v.ID;
 
--2. Lösen Sie Aufgabe 1 mit Hilfe von OUTER JOIN
SELECT *
FROM tblDevice AS d
FULL OUTER JOIN tblVendor AS v
ON d.VendorID = v.ID;
 
--Gibt es Hersteller, von denen kein Gerät in dem Bestand ist? Es sind nur die Namen der Hersteller
--anzuzeigen.
SELECT *
FROM tblDevice AS d
RIGHT OUTER JOIN tblVendor AS v
ON d.VendorID = v.ID;

--ODER
SELECT *
FROM tblVendor AS v
LEFT OUTER JOIN tblDevice AS d
ON d.VendorID = v.ID;
 