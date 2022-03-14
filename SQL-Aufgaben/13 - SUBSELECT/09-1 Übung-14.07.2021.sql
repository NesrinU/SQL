--Aufgabe 1 
USE pro_angSQL;


SELECT *
FROM abt;

SELECT *
FROM ang;

SELECT *
FROM pro;

SELECT *
FROM pro_ang;

--Verwenden Sie jeweils Unterabfragen oder Mengenoperationen, um die folgenden Aufgaben zu
--lˆsen:
--1. Wie heiﬂt die Abteilung, in der ÑMillì arbeitet?
SELECT abt_name, abt_nr
FROM abt
WHERE abt_nr =
	(
	SELECT abt_nr
	FROM ang
	WHERE name = 'Mill'
	INTERSECT
	SELECT abt_nr
	FROM abt
	)
;

--2. Wie heiﬂen die Angestellten aus der Abteilung ÑVertriebì?
SELECT name, abt_nr
FROM ang
WHERE abt_nr =
	(
	SELECT abt_nr
	FROM ang
	INTERSECT
	SELECT abt_nr
	FROM abt
	WHERE abt_name = 'Vertrieb'
	)
;

--3. Wie heiﬂen die Angestellten, die am Projekt ÑISDNì arbeiten?
SELECT name
FROM ang
WHERE a_nr = ANY
	(
	SELECT a_nr
	FROM ang
	INTERSECT 
		(
		SELECT a_nr
		FROM pro_ang
		WHERE p_nr =
			(
			SELECT p_nr
			FROM pro
			WHERE p_beschr = 'ISDN'
			)
		)
	)
;

--4. Wie heiﬂen die Projekte, an denen ÑSeelì arbeitet?
SELECT p_nr, p_beschr
FROM pro
WHERE p_nr = ANY
	(
	SELECT p_nr
	FROM pro_ang
	WHERE a_nr = 
		(
		SELECT a_nr
		FROM ang
		WHERE name = 'Seel'
		INTERSECT 
		SELECT a_nr
		FROM pro_ang
		)
	)
;

--5. Wie heiﬂen die Angestellten, deren Gehalt ¸ber dem Durchschnittsgehalt liegt?
SELECT name, gehalt
FROM ang
WHERE gehalt > 
	(
	SELECT AVG(gehalt)
	FROM ang
	)
;

--6. Wie heiﬂen die Angestellten, die weniger als das kleinste Gehalt der Abteilung Vertrieb 
--verdienen?
SELECT name, gehalt
FROM ang
WHERE gehalt < 
	(
	SELECT MIN(gehalt)
	FROM ang
	WHERE abt_nr = 
		(
		SELECT abt_nr FROM abt WHERE abt_name = 'Vertrieb'
		)
	)
;

--7. Wie heiﬂen die Abteilungsleiter, die mehr als Ä 5000 verdienen und wie hoch ist deren Gehalt?
SELECT name, gehalt
FROM ang
WHERE a_nr = ANY
	(
	SELECT abt_leiter
	FROM abt
	WHERE abt_leiter = ANY 
		(
		SELECT a_nr
		FROM ang
		WHERE gehalt > 5000
		)
	)
;

--8. Wie heiﬂen die Projekte, an denen Angestellte mehr als 80% ihrer Arbeitszeit aufwenden?
SELECT p_beschr
FROM pro
WHERE p_nr IN
	(
	SELECT p_nr
	FROM pro_ang
	WHERE proz_arb > 80
	)
;

--9. Wie heiﬂen die Projekte, an denen Angestellte aus Abteilung Ñ3ì mehr als 80% ihrer Arbeitszeit 
--aufwenden?
SELECT p_beschr
FROM pro
WHERE p_nr IN
	(
	SELECT p_nr
	FROM pro_ang
	WHERE a_nr IN
		(
		SELECT a_nr
		FROM pro_ang
		WHERE proz_arb > 80
		INTERSECT
		SELECT a_nr
		FROM ang
		WHERE abt_nr = 3
		)
	)
;

--10. Wie heiﬂen die Angestellten, die mehr als Ihre Vorgesetzten verdienen?
SELECT name
FROM ang
WHERE gehalt > ANY 
	(SELECT gehalt
	FROM ang
	WHERE a_nr IN 
		(
		SELECT vorg
		FROM ang
		)
	)

;

--11. Wie heiﬂen die Angestellten, die sowohl Abteilungsleiter als auch Vorgesetzter sind?
SELECT a_nr, name
FROM ang
WHERE a_nr = ANY
	(
	SELECT abt_leiter
	FROM abt
	INTERSECT
	SELECT vorg
	FROM ang
	)
;

--12. Wie heiﬂen die Angestellten, die Projektleiter aber keine Vorgesetzten sind?
SELECT a_nr, name
FROM ang
WHERE a_nr = ANY
	(
	SELECT abt_leiter
	FROM abt
	EXCEPT
	SELECT vorg
	FROM ang
	)
;

--13. Wie heiﬂen die Angestellten, die zwar Vorgesetzte aber keine Projektleiter sind? 
SELECT a_nr, name
FROM ang
WHERE a_nr = ANY
	(
	SELECT vorg
	FROM ang
	EXCEPT
	SELECT p_leiter
	FROM pro
	)
;