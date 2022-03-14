--Die Filmdaten sind als Basis einer Film Web-Site gedacht, in der Anwender Filme in der
--Datenbank bewerten können. Hier ist nur ganz kleiner Abschnitt der Datenbank dargestellt. 
--Importieren Sie das Script und erstellen Sie geeignete SELECT-Anweisungen:
USE Movies;

SELECT *
FROM MOV_PERSON;

SELECT *
FROM MOV_FILM;

SELECT *
FROM MOV_BESETZUNG;

--1. Wie viele Datensätze (Zeilen) gibt es jeweils in den drei Tabellen? 
USE Movies;

SELECT COUNT(*) AS Person, (SELECT COUNT(*)
FROM MOV_FILM) AS Film, (SELECT COUNT(*)
FROM MOV_BESETZUNG) AS Besetzung
FROM MOV_PERSON;
 
--2. Wie viele Filme gibt es, die einen Titel haben, der das Wort ’Gun’ im Titel enthält?
SELECT COUNT(titel) AS Anzahl_Filme
FROM MOV_FILM
WHERE titel LIKE '%gun%'


--Wie heißen die Titel dieser Filme?
SELECT titel
FROM MOV_FILM
WHERE titel LIKE '%[^a-z]gun[^a-z]%' OR titel LIKE '%[^a-z]gun' OR titel LIKE 'gun[^a-z]%'
  
--3. Welche Filme sind aus dem Jahr 1984? 
SELECT jahr, titel
FROM MOV_FILM
WHERE jahr = 1984;

--4. Wie viele Punkte erhielten die Filme aus dem Jahr 1984 durchschnittlich (auf zwei 
--Nachkommastellen gerundet)? 
SELECT ROUND(AVG(punkte), 2) AS Punkte
FROM MOV_FILM
WHERE jahr = 1984;

--5. Ermitteln Sie die durchschnittliche Punktzahl für jeden einzelnen Jahrgang! 
SELECT jahr, ROUND(AVG(punkte), 2) AS Punkte
FROM MOV_FILM
GROUP BY jahr
ORDER BY jahr ASC;

--6. Welche Jahrgänge haben einen Punkteschnitt größer als 7.0 Punkte? 
SELECT jahr, ROUND(AVG(punkte), 2) AS Punkte
FROM MOV_FILM
GROUP BY jahr
HAVING ROUND(AVG(punkte), 2) > 7.0
ORDER BY jahr ASC;

--7. Wie viele Stimmen (insgesamt) wurden für alle Filme im Jahr 1984 abgegeben? 
SELECT jahr, SUM(stimmen) AS Stimmen
FROM MOV_FILM
WHERE jahr = 1984
GROUP BY jahr;

--8. In welchen Spielfilmen hat Harrison Ford mitgespielt? 
SELECT id, titel
FROM MOV_FILM
WHERE id = ANY
	(
	SELECT filmid
	FROM MOV_BESETZUNG
	WHERE persid =
		(
		SELECT id
		FROM MOV_PERSON
		WHERE name = 'Harrison Ford'
		)
	)
;
--9. Bei welchen Filmen hat Ridley Scott Regie geführt? 
SELECT id, titel
FROM MOV_FILM
WHERE regie = ANY
	(
	SELECT id
	FROM MOV_PERSON
	WHERE name = 'Ridley Scott'
	)
;

--10. Welche Schauspieler haben in dem Film ’Blade Runner’ mitgespielt? 
SELECT name
FROM MOV_PERSON
WHERE id = ANY
	(
	SELECT persid
	FROM MOV_BESETZUNG
	WHERE filmid =
		(
		SELECT id
		FROM MOV_FILM
		WHERE titel = 'Blade Runner'
		)
	)
;
--11. Wer hat in einem Film die Hauptrolle (ord=1) gespielt und Regie geführt? 
SELECT name
FROM MOV_PERSON
WHERE id = ANY
	(
	SELECT persid
	FROM MOV_BESETZUNG
	WHERE ord = 1 
	INTERSECT
	SELECT regie
	FROM MOV_FILM
	)
;

--12. Gibt es Schauspieler in der Datenbank, die noch nie eine Hauptrolle gespielt haben? 
SELECT name
FROM MOV_PERSON
WHERE id = ANY
	(
	SELECT id
	FROM MOV_PERSON
	EXCEPT
	SELECT persid
	FROM MOV_BESETZUNG
	WHERE ord = 1
	)
;
--13. Wer hat in dem Film mit der schlechtesten Bewertung mitgespielt? 
SELECT name
FROM MOV_PERSON
WHERE id = ANY
	(
	SELECT persid
	FROM MOV_BESETZUNG
	WHERE filmid =
		(
		SELECT id
		FROM MOV_FILM
		WHERE punkte =
			(
			SELECT MIN(punkte)
			FROM MOV_FILM
			)
		)
	)
;

--14. Welche durchschnittliche Bewertung haben die Filme von Woody Allen?  
SELECT AVG(punkte) AS Filme_Woody_Allen
FROM MOV_FILM
WHERE id = ANY
	(
	SELECT id
	FROM MOV_FILM
	WHERE regie =
		(
		SELECT id
		FROM MOV_PERSON
		WHERE name = 'Woody Allen'
		)
	UNION
	SELECT filmid
	FROM MOV_BESETZUNG
	WHERE persid =
		(
		SELECT id
		FROM MOV_PERSON
		WHERE name = 'Woody Allen'
		)
	)
;

--Erhöhter Schwierigkeitsgrad:
 
--15. Was sind die besten Jahrgänge, welche die Schlechtesten (bezüglich der Punkte)? 
   

SELECT * 
FROM 
	(SELECT TOP 1 jahr, ROUND(AVG(punkte),2) AS Punkte
	FROM MOV_FILM
	GROUP BY jahr
	ORDER BY Punkte ASC) t1
UNION
SELECT * 
FROM 
	(SELECT TOP 1 jahr, ROUND(AVG(punkte),2) AS Punkte
	FROM MOV_FILM
	GROUP BY jahr
	ORDER BY Punkte DESC) t2
	



--16. Was ist der beste, was der schlechteste Film (bezüglich der Punkte) von Harrison 
--Ford?  
SELECT titel, punkte
FROM MOV_FILM
WHERE id = ANY
	(
	SELECT id
	FROM MOV_FILM
	WHERE regie =
		(
		SELECT id
		FROM MOV_PERSON
		WHERE name = 'Harrison Ford'
		)
	UNION
	SELECT filmid
	FROM MOV_BESETZUNG
	WHERE persid =
		(
		SELECT id
		FROM MOV_PERSON
		WHERE name = 'Harrison Ford'
		)
	) AND punkte IN
	(
	(SELECT MIN(punkte)
	FROM MOV_FILM
	WHERE id = ANY
		(
		SELECT id
		FROM MOV_FILM
		WHERE regie =
			(
			SELECT id
			FROM MOV_PERSON
			WHERE name = 'Harrison Ford'
			)
		UNION
		SELECT filmid
		FROM MOV_BESETZUNG
		WHERE persid =
			(
			SELECT id
			FROM MOV_PERSON
			WHERE name = 'Harrison Ford'
			))), 
	 (SELECT MAX(punkte)
	FROM MOV_FILM
	WHERE id = ANY
		(
		SELECT id
		FROM MOV_FILM
		WHERE regie =
			(
			SELECT id
			FROM MOV_PERSON
			WHERE name = 'Harrison Ford'
			)
		UNION
		SELECT filmid
		FROM MOV_BESETZUNG
		WHERE persid =
			(
			SELECT id
			FROM MOV_PERSON
			WHERE name = 'Harrison Ford'
			)
		)))


--ODER
WITH Harrison (Titel, Punkte) AS 
	(
	SELECT f.titel, f.punkte
	FROM MOV_PERSON AS p
	INNER JOIN MOV_BESETZUNG AS b
	ON p.id = b.persid
	INNER JOIN MOV_FILM AS f
	ON  f.id = b.filmid AND p.name = 'Harrison Ford'
	)
SELECT *
FROM Harrison
WHERE Punkte IN
	(
	SELECT MIN(Punkte) FROM Harrison
	UNION
	SELECT MAX(Punkte) FROM Harrison
	);