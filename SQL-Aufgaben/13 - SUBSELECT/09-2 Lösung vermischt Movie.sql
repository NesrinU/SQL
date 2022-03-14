---------------------------------------------------------
-- 1 - Datensätze pro Tabelle
---------------------------------------------------------
SELECT
	COUNT(*) [Datensätze], 'Besetzung' Tabelle  
FROM MOV_BESETZUNG 
UNION 
SELECT 
	COUNT(*), 'Film'  
FROM MOV_FILM 
UNION 
SELECT
	COUNT(*), 'Person'  
FROM MOV_PERSON;



select count(*) as Zeilen_Person,
(select count(*) from MOV_BESETZUNG) as zeilebeset,
(select count(*) from MOV_FILM) as zeileFilm from MOV_PERSON

---------------------------------------------------------
-- 2 - Knarren
---------------------------------------------------------
-- Hier die Zeichenfolge gun
SELECT
	COUNT(titel) 
FROM 
	MOV_FILM 
WHERE 
	titel like '%Gun%';
 
SELECT 
	[id],titel,jahr,punkte,stimmen,regie 
FROM MOV_FILM  
WHERE 
	titel LIKE '%Gun%';
-- Das Wort gun
SELECT COUNT(titel) AS [Anz. Filme]
FROM mov_film
WHERE titel LIKE '%[^a-z]gun[^a-z]%' OR titel LIKE '%[^a-z]gun'

SELECT titel FROM mov_film WHERE titel LIKE '%[^a-z]gun[^a-z]%' OR titel LIKE '%[^a-z]gun'

---------------------------------------------------------
-- 3 - 1984
---------------------------------------------------------

SELECT 
	[id],titel,jahr,punkte,stimmen,regie 
FROM MOV_FILM  
WHERE 
	jahr = 1984;
	
---------------------------------------------------------
-- 4 - Punkteschnitt 1984
---------------------------------------------------------
SELECT 
	Format(AVG(punkte), '0,00') Punkteschnitt
FROM MOV_FILM  
WHERE 
	jahr = 1984;
	
---------------------------------------------------------
-- 5 - Punkteschnitt, alle Jahre
---------------------------------------------------------
SELECT 
	jahr,
	ROUND(AVG(punkte),2) Punkteschnitt
FROM MOV_FILM 
GROUP BY jahr;

---------------------------------------------------------
-- 6 - Punkteschnitt > 7, alle jahre
---------------------------------------------------------
SELECT 
	jahr,
	ROUND(AVG(punkte),2) Punkteschnitt
FROM MOV_FILM 
GROUP BY jahr
HAVING ROUND(AVG(punkte),2) > 7;

---------------------------------------------------------
-- 7 - Summe der Stimmen in 1984
---------------------------------------------------------
SELECT 
	SUM(Stimmen) Gesamtstimmen
FROM MOV_FILM  
WHERE 
	jahr = 1984;
	
---------------------------------------------------------
-- 8 - Indiana Solo
---------------------------------------------------------

SELECT 
	F.titel 
FROM 
	MOV_PERSON P  
INNER JOIN 
	MOV_BESETZUNG B  
ON P.[id] = B.persid 
INNER JOIN 
	MOV_FILM F 
ON F.[id] = B.filmid AND P.[name] like 'Harrison Ford';


SELECT titel AS[Filme in denen Harrison Ford mitgespielt hat] 
FROM MOV_FILM WHERE id IN(SELECT filmid FROM MOV_BESETZUNG 
WHERE persid = (SELECT id FROM MOV_PERSON 
WHERE name LIKE '%harrison ford%')) ORDER BY titel ASC
---------------------------------------------------------
-- 9 - Ridley Scott - Regie
---------------------------------------------------------

SELECT f.titel
FROM MOV_FILM f
INNER JOIN MOV_PERSON p
ON f.regie = p.id 
WHERE p.name = 'Ridley Scott';


SELECT titel AS Film FROM MOV_FILM 
WHERE regie = (
SELECT id FROM MOV_PERSON 
WHERE name LIKE 'Ridley Scott')
---------------------------------------------------------
-- 10 - Blade Runner Cast
---------------------------------------------------------

SELECT 
	p.name
FROM 
	MOV_PERSON P  
INNER JOIN 
	MOV_BESETZUNG B  
ON P.[id] = B.persid 
INNER JOIN 
	MOV_FILM F 
ON F.[id] = B.filmid AND F.[titel] like 'Blade Runner'
ORDER BY b.ord;

select MOV_PERSON.name from MOV_PERSON  where exists 
(select MOV_FILM.titel from MOV_FILM,MOV_BESETZUNG 
where MOV_FILM.id=MOV_BESETZUNG.filmid
and MOV_BESETZUNG.persid=MOV_PERSON.id and MOV_FILM.titel='Blade Runner')

select name as Name from MOV_PERSON 
where id in (select persid from MOV_BESETZUNG where 
filmid = (select id from MOV_FILM where titel = 'Blade Runner'))

---------------------------------------------------------
-- 11 - Hauptdarsteller & Regie im selben Film
---------------------------------------------------------

SELECT f.titel,	p.name
FROM MOV_PERSON AS P  
INNER JOIN MOV_BESETZUNG AS B  
ON P.[id] = B.persid 
INNER JOIN MOV_FILM AS F 
ON F.[id] = B.filmid AND b.ord = 1 AND F.regie = p.id;

select name from MOV_PERSON where id in
(
select persid from MOV_BESETZUNG 
where ord = 1 
intersect 
select regie from MOV_FILM) -- 43 Treffer 



SELECT name AS [Regiesseure und Hauptdarsteller] 

FROM MOV_PERSON WHERE ID IN(
SELECT DISTINCT regie FROM MOV_FILM WHERE regie 
IN(
SELECT persid FROM MOV_BESETZUNG WHERE ord = 1)) 
ORDER BY name ASC -- 43 Treffer

---------------------------------------------------------
-- 12 - Nie Hauptdarsteller
---------------------------------------------------------
	
SELECT 
	MIN(B.ord), 
	P.Name 
FROM
	MOV_PERSON P
		INNER JOIN
	MOV_BESETZUNG B
ON P.ID = B.Persid
GROUP BY P.Name
HAVING min(B.ord) > 1
ORDER BY 1 DESC;

---------------------------------------------------------
-- 13 - Cast im schlechtesten Film
---------------------------------------------------------

SELECT 
	f.titel,
	p.name
FROM 
	MOV_PERSON P  
INNER JOIN 
	MOV_BESETZUNG B  
ON P.[id] = B.persid 
INNER JOIN 
	MOV_FILM F 
ON F.[id] = B.filmid 
	AND F.punkte = (SELECT MIN(Punkte) FROM MOV_FILM);


---------------------------------------------------------
-- 14 - Woodys Durchschnitt
---------------------------------------------------------

SELECT
	ROUND(AVG(F.Punkte),2) Schnitt
FROM 
	MOV_FILM F
INNER JOIN 
	MOV_PERSON P
ON F.regie = P.id AND p.name = 'Woody Allen';

---------------------------------------------------------
-- 15 - Bester/Schlechtester Jahrgang
---------------------------------------------------------

WITH SCHNITT (SchnittPunkte, Jahr) AS 
(
	SELECT 
		ROUND(AVG(Punkte),2) SchnittPunkte,
		JAHR
	FROM
		MOV_FILM
	GROUP BY JAHR
)
SELECT * FROM SCHNITT
WHERE 
	SchnittPunkte IN 
	( 
		(SELECT MIN(SchnittPunkte) FROM SCHNITT)
		,
		(SELECT MAX(SchnittPunkte) FROM SCHNITT)
	);
	
-- ODER
SELECT * FROM (
SELECT TOP 1
	jahr,
	ROUND(AVG(punkte),2) Punkteschnitt
FROM MOV_FILM 
GROUP BY jahr ORDER BY 2 DESC
) t
UNION
SELECT * FROM (
SELECT TOP 1
	jahr,
	ROUND(AVG(punkte),2) Punkteschnitt
FROM MOV_FILM 
GROUP BY jahr ORDER BY 2) t1;
-- ODER

SELECT 
	jahr,
	ROUND(AVG(punkte),2) Punkteschnitt
FROM MOV_FILM 
GROUP BY jahr
HAVING ROUND(AVG(punkte),2) IN (
SELECT MIN ( Punkteschnitt ) FROM (
SELECT 
	ROUND(AVG(punkte),2) Punkteschnitt
FROM MOV_FILM 
GROUP BY jahr ) t
UNION
SELECT MAX ( Punkteschnitt ) FROM (
SELECT 
	
	ROUND(AVG(punkte),2) Punkteschnitt
FROM MOV_FILM 
GROUP BY jahr ) t1 )

---------------------------------------------------------
-- 16 - Bester/Schlechtester Harrison Ford
---------------------------------------------------------

WITH Harrison (Titel, Punkte)
AS (
SELECT 
	F.titel, punkte 
FROM 
	MOV_PERSON P  
INNER JOIN 
	MOV_BESETZUNG B  
ON P.[id] = B.persid 
INNER JOIN 
	MOV_FILM F 
ON F.[id] = B.filmid AND P.[name] like 'Harrison Ford' 
)
SELECT * FROM Harrison
WHERE Punkte IN 
(
	SELECT MIN(Punkte) FROM Harrison
	UNION
	SELECT MAX(Punkte) FROM Harrison
);

