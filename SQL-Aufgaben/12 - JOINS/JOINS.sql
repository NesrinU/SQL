USE JoinDB1;

SELECT * 
FROM Kfz;

SELECT * 
FROM Pers;

SELECT * 
FROM Pers CROSS JOIN Kfz;

SELECT P.Nachname, K.ID 
FROM Pers AS P CROSS JOIN Kfz AS K
WHERE K.ID > 9;

SELECT P.Vorname + ' ' + P.Nachname AS Name, K.Kennzeichen 
FROM Pers AS P CROSS JOIN Kfz AS K
WHERE K.ID > 9;

SELECT P.Vorname + ' ' + P.Nachname AS Name, K.Kennzeichen
FROM Pers AS P
INNER JOIN Kfz AS K
ON P.Kfz = K.ID;

SELECT P.Vorname + ' ' + P.Nachname AS Name, K.Kennzeichen
FROM Pers AS P
LEFT OUTER JOIN Kfz AS K
ON P.Kfz = K.ID;

SELECT P.Vorname + ' ' + P.Nachname AS Name, K.Kennzeichen
FROM Pers AS P
RIGHT OUTER JOIN Kfz AS K
ON P.Kfz = K.ID;

SELECT P.Vorname + ' ' + P.Nachname AS Name, K.Kennzeichen
FROM Pers AS P
FULL OUTER JOIN Kfz AS K
ON P.Kfz = K.ID;

