--Aufgabe 1
SELECT abt_name
FROM abt
WHERE abt_nr = (
	SELECT abt_nr
	FROM ang
	WHERE name = 'Mill'
)

--Aufgabe 2
SELECT name
FROM ang
WHERE abt_nr = (
	SELECT abt_nr
	FROM abt
	WHERE abt_name = 'Vertrieb'
)

--Aufgabe 3
-- Projekt 33 - Angestellte 117  400  401  - Seel Klef Paul
SELECT name FROM ang
WHERE a_nr IN (
	SELECT a_nr FROM pro_ang 
	WHERE p_nr = (
	SELECT p_nr FROM pro
		WHERE p_beschr = 'ISDN'
	)
)

-- abhängige Unterabfrage
select ang.name from ang
 
where exists(select pro.p_beschr from pro,pro_ang 

where pro_ang.a_nr=ang.a_nr and 
pro.p_nr=pro_ang.p_nr and pro.p_beschr='ISDN')

--Aufgabe 4
-- Seel = a_nr 217 = Projektnr 18 , 33 --- P4, P5 sind DBS, ISDN
SELECT p_name, p_beschr
FROM pro WHERE p_nr IN(
	SELECT p_nr FROM pro_ang WHERE a_nr=(
	SELECT a_nr FROM ang WHERE [name]='Seel'
	)
)


--Aufgabe 5
--- Wind, Karl, Mill, Otto, Paul verdienen mehr als 4554,- €
SELECT [name], gehalt FROM ang
WHERE gehalt > (SELECT avg(gehalt) FROM ang
)


--Aufgabe 6
-- Vertrieb = Abteilung 2  Min Gehalt ist 5000,- €   
-- 6 Angesetellte verdienen weniger
SELECT [name], gehalt
FROM ang WHERE gehalt <(
	SELECT min(gehalt) FROM ang
	WHERE abt_nr = (
		SELECT abt_nr FROM abt
		WHERE abt_name = 'Vertrieb'
	)
)

--Aufgabe 7
-- AbtLeiter sind 205,301,307  
-- Wind und Mill vedienen über 5000,- 
SELECT [name], gehalt
FROM ang WHERE gehalt > 5000
AND a_nr IN(
	SELECT abt_leiter FROM abt
)

SELECT [name], gehalt FROM ang 
WHERE gehalt > 5000 AND a_nr = any(
	SELECT abt_leiter FROM abt)

	
--Aufgabe 8
-- nur Projekt 33 hat über 80 %
-- Projekt ISDN

SELECT p_name, p_beschr
FROM pro
WHERE p_nr IN(
	SELECT p_nr FROM pro_ang
	WHERE proz_arb >80
)


--Aufgabe 9
-- 6  Angestellte in Abteilung 3
-- sie arbeiten an den Projekten 18 und 33 mit über 50 % 
-- das sind die Projekte 4 und 5: DBS, ISDN

SELECT p_name, p_beschr FROM pro
WHERE p_nr IN (
	SELECT p_nr FROM pro_ang
	WHERE proz_arb > 50
	AND a_nr IN (
		SELECT a_nr FROM ang 
		WHERE abt_nr = 3
	)
)

select pro.p_name,pro.p_nr, pro.p_beschr 
from pro where exists 

(select proz_arb from pro_ang,ang 

where	 pro_ang.p_nr=pro.p_nr and 
	 pro_ang.proz_arb>80 and 
	 ang.abt_nr=3)


--Aufgabe 10
--korrelierte Abfrage
--reflexive Beziehung
-- Nur Mill verdient mehr als sein Vogesetzter
SELECT name, gehalt
FROM ang
WHERE gehalt >(
	SELECT gehalt 
	FROM ang v
	WHERE v.a_nr = ang.vorg
)

Select b.name as Angestellter, 
b.gehalt as Angestelltengehalt, 

b.beruf as [Ausgeübter Beruf], 
a.name as Vorgesetzter, 

a.gehalt as Vorgesetztengehalt 

from ang as a 
left outer join ang as b 

on a.a_nr = b.vorg 

where a.gehalt < b.gehalt


--Aufgabe 11
--am besten:
select name from ang where a_nr IN (
select abt_leiter from abt intersect  
select vorg from ang )


-- korreliert
-- 3 Abteilungsleiter: Mill, Karl und Wind
-- 3 Vorgesetzte: Feld, Wind und Paul
-- Wind ist beides
SELECT [name]
FROM ang
WHERE EXISTS (
	SELECT *
	FROM abt
	WHERE abt_leiter = ang.a_nr
)
INTERSECT
SELECT [name]
FROM ang
WHERE EXISTS(
	SELECT DISTINCT vorg 
	FROM ang v
	WHERE v.vorg = ang.a_nr
)


-- unabh. Unterabfagen

select * from ang 
where 
a_nr 
in (select vorg from ang) 
  and 
a_nr in (select abt_leiter from abt)

--Aufgabe 12
-- 3 Projektleiter: Seel, Wind, Mill
-- Vorgesetzte sind: Feld, Wind, Paul
-- Wind fällt raus: Seel, Mill

SELECT [name]
FROM ang
WHERE EXISTS (
	SELECT *
	FROM pro
	WHERE p_leiter = ang.a_nr
)
EXCEPT
SELECT [name]
FROM ang
WHERE EXISTS(
	SELECT DISTINCT vorg 
	FROM ang v
	WHERE v.vorg = ang.a_nr
)

-- Alternative kürzer
select name from ang

where a_nr in 
(select p_leiter from pro

except select vorg from ang)

     
--Aufgabe 13
-- Vorgesetzte sind: Feld, Wind, Paul
-- 3 Projektleiter: Seel, Wind, Mill
-- Wind fällt raus: Feld, Paul
SELECT [name]
FROM ang
WHERE EXISTS(
	SELECT DISTINCT vorg 
	FROM ang v
	WHERE v.vorg = ang.a_nr
)
EXCEPT
SELECT [name]
FROM ang
WHERE EXISTS (
	SELECT *
	FROM pro
	WHERE p_leiter = ang.a_nr
)